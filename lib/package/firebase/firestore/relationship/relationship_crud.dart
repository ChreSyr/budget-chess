import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crea_chess/package/firebase/firestore/crud/collection_crud.dart';
import 'package:crea_chess/package/firebase/firestore/relationship/relationship_model.dart';

class _RelationshipCRUD extends CollectionCRUD<RelationshipModel> {
  _RelationshipCRUD()
      : super(
          collectionName: 'relationship',
          toFirestore: (
            RelationshipModel data,
            SetOptions? _,
          ) =>
              data.toFirestore(),
          fromFirestore: (
            DocumentSnapshot<Map<String, dynamic>> snapshot,
            SnapshotOptions? _,
          ) =>
              RelationshipModel.fromFirestore(snapshot),
        );

  Future<void> block({
    required String blockerId,
    required String toBlockId,
  }) async {
    final sortedUsers = [blockerId, toBlockId]..sort();

    final RelationshipStatus newStatus;
    if (blockerId == sortedUsers.first) {
      newStatus = RelationshipStatus.blockedByFirst;
    } else if (blockerId == sortedUsers.last) {
      newStatus = RelationshipStatus.blockedByLast;
    } else {
      return;
    }

    final relationshipId = sortedUsers.join();

    final relationship = await read(documentId: relationshipId);
    if (relationship == null) {
      return create(
        documentId: relationshipId,
        data: RelationshipModel(
          id: relationshipId,
          userIds: sortedUsers,
          status: newStatus,
        ),
      );
    }

    if ([RelationshipStatus.blockedByFirst, RelationshipStatus.blockedByLast]
        .contains(relationship.status)) return;

    await update(
      documentId: relationshipId,
      data: relationship.copyWith(status: newStatus),
    );
  }

  Future<void> cancel({
    required String cancelerId,
    required String otherId,
  }) async {
    final relationshipId = getId(cancelerId, otherId);
    final relationship = await read(documentId: relationshipId);
    if (relationship == null) return;

    if (relationship.status != RelationshipStatus.friends) return;

    await update(
      documentId: relationshipId,
      data: relationship.copyWith(status: RelationshipStatus.canceled),
    );
  }

  Future<void> cancelFriendRequest({
    required String cancelerId,
    required String otherId,
  }) async {
    final relationshipId = getId(cancelerId, otherId);
    final relationship = await read(documentId: relationshipId);
    if (relationship == null || relationship.requester != cancelerId) return;

    await delete(documentId: relationshipId);
  }

  Stream<Iterable<RelationshipModel>> friendsOf(String? userId) {
    return streamFiltered(
      filter: (collection) => collection
          .where('userIds', arrayContains: userId)
          .where('status', isEqualTo: RelationshipStatus.friends.name),
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
    if (relation == null ||
        ![
          RelationshipStatus.requestedByFirst,
          RelationshipStatus.requestedByLast,
        ].contains(relation.status)) return;

    await super.update(
      documentId: relationshipId,
      data: relation.copyWith(
        createdAt: DateTime.now(),
        status: RelationshipStatus.friends,
      ),
    );
  }

  /// Return the relationships waiting for an answer, from or to userId
  Stream<Iterable<RelationshipModel>> requestsAbout(String userId) {
    return streamFiltered(
      filter: (collection) =>
          collection.where('userIds', arrayContains: userId).where(
                Filter.or(
                  Filter(
                    'status',
                    isEqualTo: RelationshipStatus.requestedByFirst.name,
                  ),
                  Filter(
                    'status',
                    isEqualTo: RelationshipStatus.requestedByLast.name,
                  ),
                ),
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
    if (relation != null && relation.status != RelationshipStatus.canceled) {
      return;
    }

    final status = fromUserId == sortedUsers[0]
        ? RelationshipStatus.requestedByFirst
        : RelationshipStatus.requestedByLast;

    await super.create(
      documentId: relationshipId,
      data: RelationshipModel(
        id: '', // will not be stored in firebase
        userIds: sortedUsers,
        status: status,
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
      data: relationship.copyWith(status: RelationshipStatus.canceled),
    );
  }
}

final relationshipCRUD = _RelationshipCRUD();
