import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/firebase/firestore/crud/collection_crud.dart';

class _RelationshipCRUD extends CollectionCRUD<RelationshipModel> {
  _RelationshipCRUD() : super(collectionName: 'relationship');

  @override
  RelationshipModel? jsonToModel(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? _,
  ) {
    try {
      final json = snapshot.data() ?? {};
      json['id'] = snapshot.id;
      return RelationshipModel.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, Object?> modelToJson(RelationshipModel? data, SetOptions? _) {
    return (data?.toJson()
          ?..removeWhere(
            (key, value) => key == 'id' || value == null,
          )) ??
        {};
  }

  Future<void> block({
    required String blockerId,
    required String toBlockId,
  }) async {
    final sortedUsers = [blockerId, toBlockId]..sort();
    final relationshipId = sortedUsers.join();
    final relationship = await read(documentId: relationshipId);

    if (relationship == null) {
      return create(
        documentId: relationshipId,
        data: RelationshipModel(
          id: relationshipId,
          users: {
            blockerId: UserInRelationshipStatus.blocks,
            toBlockId: UserInRelationshipStatus.isBlocked,
          },
          lastUserStatusUpdate: DateTime.now(),
        ),
      );
    }

    if (relationship.statusOf(blockerId) == UserInRelationshipStatus.blocks) {
      return;
    }

    await update(
      documentId: relationshipId,
      data: relationship.copyWith(
        users: {
          blockerId: UserInRelationshipStatus.blocks,
          toBlockId: UserInRelationshipStatus.isBlocked,
        },
        lastUserStatusUpdate: DateTime.now(),
      ),
    );
  }

  /// Only effective if the canceler status was open
  Future<void> cancel({
    required String cancelerId,
    required String otherId,
  }) async {
    final relationshipId = getId(cancelerId, otherId);
    final relationship = await read(documentId: relationshipId);
    if (relationship == null) return;

    if (relationship.statusOf(cancelerId) != UserInRelationshipStatus.open) {
      return;
    }

    await update(
      documentId: relationshipId,
      data: relationship.copyWith(
        users: {
          cancelerId: UserInRelationshipStatus.cancels,
          otherId: UserInRelationshipStatus.isCanceled,
        },
        lastUserStatusUpdate: DateTime.now(),
      ),
    );
  }

  Future<void> cancelFriendRequest({
    required String cancelerId,
    required String otherId,
  }) async {
    final relationshipId = getId(cancelerId, otherId);
    final relationship = await read(documentId: relationshipId);
    if (relationship == null || relationship.requester != cancelerId) return;

    final newUsers = relationship.copyOfUsers;
    newUsers[cancelerId] = UserInRelationshipStatus.none;
    newUsers[otherId] = UserInRelationshipStatus.none;

    await update(
      documentId: relationshipId,
      data: relationship.copyWith(
        users: newUsers,
        lastUserStatusUpdate: DateTime.now(),
      ),
    );
  }

  Future<Iterable<RelationshipModel>> readFriendshipsOf(String? userId) {
    return readFiltered(
      filter: (collection) => collection.where(
        'users.$userId',
        isEqualTo: UserInRelationshipStatus.open.name,
      ),
    );
  }

  Stream<Iterable<RelationshipModel>> streamFriendshipsOf(String? userId) {
    return streamFiltered(
      filter: (collection) => collection.where(
        'users.$userId',
        isEqualTo: UserInRelationshipStatus.open.name,
      ),
    );
  }

  String getId(String user1, String user2) {
    final sortedUsers = [user1, user2]..sort();
    return sortedUsers.join();
  }

  Future<void> makeFriends(String user1, String user2) async {
    final sortedUsers = [user1, user2]..sort();
    final relationshipId = sortedUsers.join();
    final relation = await read(documentId: relationshipId);

    // A friendship starts with a friend request
    if (relation == null || relation.requester == null) return;

    final friendship = relation.copyWith(
      users: {
        user1: UserInRelationshipStatus.open,
        user2: UserInRelationshipStatus.open,
      },
      lastUserStatusUpdate: DateTime.now(),
    );
    await update(
      documentId: relationshipId,
      data: friendship,
    );

    await messageCRUD.onFriendshipStart(friendship: friendship);
  }

  /// Close the relationships of this user
  Future<void> onAccountDeletion({required String userId}) async {
    final relationships = await readFiltered(
      filter: (collection) => collection.orderBy('users.$userId'),
    );
    for (final relationship in relationships) {
      final newUsers = relationship.copyOfUsers;
      newUsers[userId] = UserInRelationshipStatus.none;

      final otherId = relationship.otherUser(userId);
      if (otherId == null) continue; // should never happen
      if (relationship.statusOf(otherId) == UserInRelationshipStatus.open) {
        newUsers[otherId] = UserInRelationshipStatus.isCanceled;
      } else if (relationship.statusOf(otherId) ==
          UserInRelationshipStatus.requests) {
        newUsers[otherId] = UserInRelationshipStatus.isRefused;
      }

      await update(
        documentId: relationship.id,
        data: relationship.copyWith(
          users: newUsers,
          lastUserStatusUpdate: DateTime.now(),
        ),
      );
      await delete(documentId: relationship.id);
    }
  }

  Future<void> refuseFriendRequest({
    required String refuserId,
    required String requesterId,
  }) async {
    final relationshipId = getId(refuserId, requesterId);
    final relationship = await read(documentId: relationshipId);
    if (relationship == null || relationship.requester != requesterId) return;

    await update(
      documentId: relationshipId,
      data: relationship.copyWith(
        users: {
          refuserId: UserInRelationshipStatus.refuses,
          requesterId: UserInRelationshipStatus.isRefused,
        },
        lastUserStatusUpdate: DateTime.now(),
      ),
    );
  }

  Future<void> refuseSuggestion({
    required String refuser,
    required RelationshipModel relationship,
  }) async {
    final refused = relationship.otherUser(refuser);
    if (refused == null) return;

    // relation may not exist yet
    await create(
      documentId: relationship.id,
      data: relationship.copyWith(
        users: {
          refuser: UserInRelationshipStatus.refuses,
          refused: UserInRelationshipStatus.isRefused,
        },
        lastUserStatusUpdate: DateTime.now(),
      ),
    );
  }

  /// Return the relationships waiting for an answer, from or to userId
  Stream<Iterable<RelationshipModel>> streamRequestsFrom(String userId) {
    return streamFiltered(
      filter: (collection) => collection.where(
        'users.$userId',
        isEqualTo: UserInRelationshipStatus.requests.name,
      ),
    );
  }

  /// Return the relationships waiting for an answer, from or to userId
  Stream<Iterable<RelationshipModel>> streamRequestsTo(String userId) {
    return streamFiltered(
      filter: (collection) => collection.where(
        'users.$userId',
        isEqualTo: UserInRelationshipStatus.isRequested.name,
      ),
    );
  }

  Future<void> sendFriendRequest({
    required String fromUserId,
    required String toUserId,
  }) async {
    if (fromUserId == toUserId) return; // Can't be your own friend, dude

    final sortedUsers = [fromUserId, toUserId]..sort();
    final relationshipId = sortedUsers.join();

    final relation = await read(documentId: relationshipId);

    if (relation == null) {
      return create(
        documentId: relationshipId,
        data: RelationshipModel(
          id: relationshipId,
          users: {
            fromUserId: UserInRelationshipStatus.requests,
            toUserId: UserInRelationshipStatus.isRequested,
          },
          lastUserStatusUpdate: DateTime.now(),
        ),
      );
    }

    if (!relation.canSendFriendRequest(fromUserId)) return;

    if (relation.statusOf(toUserId) == UserInRelationshipStatus.requests) {
      return makeFriends(toUserId, fromUserId);
    }

    await update(
      documentId: relationshipId,
      data: RelationshipModel(
        id: '', // will not be stored in firebase
        users: {
          fromUserId: UserInRelationshipStatus.requests,
          toUserId: UserInRelationshipStatus.isRequested,
        },
        lastUserStatusUpdate: DateTime.now(),
      ),
    );
  }

  Future<void> unblock({
    required String blockerId,
    required String toUnblockId,
  }) async {
    final sortedUsers = [blockerId, toUnblockId]..sort();
    final relationshipId = sortedUsers.join();
    final relationship = await read(documentId: relationshipId);
    if (relationship == null) return;
    if (!relationship.isBlockedBy(blockerId)) return;

    await update(
      documentId: relationshipId,
      data: relationship.copyWith(
        users: {
          blockerId: UserInRelationshipStatus.none,
          toUnblockId: UserInRelationshipStatus.none,
        },
        lastUserStatusUpdate: DateTime.now(),
      ),
    );
  }

  Future<void> updateChat({required String relationshipId}) async {
    final relationship = await read(documentId: relationshipId);
    if (relationship == null) return;

    await update(
      documentId: relationshipId,
      data: relationship.copyWith(lastChatUpdate: DateTime.now()),
    );
  }
}

final relationshipCRUD = _RelationshipCRUD();
