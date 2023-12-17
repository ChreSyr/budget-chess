import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crea_chess/package/chat/flutter_chat_types/flutter_chat_types.dart'
    as types;
import 'package:crea_chess/package/firebase/firestore/crud/base_crud.dart';
import 'package:crea_chess/package/firebase/firestore/crud/model_converter.dart';
import 'package:crea_chess/package/firebase/firestore/relationship/relationship_model.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_model.dart';

class _RelationshipModelConverter implements ModelConverter<RelationshipModel> {
  @override
  RelationshipModel fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? _,
  ) {
    return RelationshipModel.fromFirestore(snapshot);
  }

  @override
  Map<String, dynamic> toFirestore(RelationshipModel data, SetOptions? _) {
    return data.toFirestore();
  }

  @override
  RelationshipModel emptyModel() {
    return RelationshipModel();
  }
}

class _RelationshipCRUD extends BaseCRUD<RelationshipModel> {
  _RelationshipCRUD() : super('relationship', _RelationshipModelConverter());

  CollectionReference<Map<String, dynamic>> _messagesCollection(
    String relationshipId,
  ) =>
      FirebaseFirestore.instance
          .collection('$collectionName/$relationshipId/messages');

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
        userIds: sortedUsers,
        status: status,
      ),
    );
  }

  /// Sends a message to the Firestore. Accepts any partial message and a
  /// room ID. If arbitraty data is provided in the [partialMessage]
  /// does nothing.
  Future<void> sendMessage(
    String senderId,
    String relationshipId, // TODO : receiverId
    dynamic partialMessage,
  ) async {
    types.Message? message;

    if (partialMessage is types.PartialCustom) {
      message = types.CustomMessage.fromPartial(
        authorId: senderId,
        id: '',
        partialCustom: partialMessage,
      );
    } else if (partialMessage is types.PartialFile) {
      message = types.FileMessage.fromPartial(
        authorId: senderId,
        id: '',
        partialFile: partialMessage,
      );
    } else if (partialMessage is types.PartialImage) {
      message = types.ImageMessage.fromPartial(
        authorId: senderId,
        id: '',
        partialImage: partialMessage,
      );
    } else if (partialMessage is types.PartialText) {
      message = types.TextMessage.fromPartial(
        authorId: senderId,
        id: '',
        partialText: partialMessage,
      );
    }

    if (message != null) {
      final messageMap = message.toJson()
        ..removeWhere((key, value) => key == 'id');
      messageMap['createdAt'] = DateTime.now();
      messageMap['updatedAt'] = DateTime.now();

      await _messagesCollection(relationshipId).add(messageMap);

      // await FirebaseFirestore.instance
      //     .collection(collectionName)
      //     .doc(relationshipId)
      //     .update({'updatedAt': DateTime.now()});
    }
  }

  /// Returns a stream of messages for a relation.
  Stream<List<types.Message>> streamMessages({
    required List<UserModel> users, // TODO : rework
    required String relationshipId,
    List<Object?>? endAt,
    List<Object?>? endBefore,
    int? limit,
    List<Object?>? startAfter,
    List<Object?>? startAt,
  }) {
    var query = _messagesCollection(relationshipId)
        .orderBy('createdAt', descending: true);

    if (endAt != null) {
      query = query.endAt(endAt);
    }

    if (endBefore != null) {
      query = query.endBefore(endBefore);
    }

    if (limit != null) {
      query = query.limit(limit);
    }

    if (startAfter != null) {
      query = query.startAfter(startAfter);
    }

    if (startAt != null) {
      query = query.startAt(startAt);
    }

    return query.snapshots().map(
          (snapshot) => snapshot.docs.fold<List<types.Message>>(
            [],
            (previousValue, doc) {
              final data = doc.data();

              // TODO : rework
              final author = users.firstWhere(
                (user) => user.id == data['authorId'],
                orElse: () => UserModel(
                  id: data['authorId'] as String,
                ),
              );

              data['author'] = author.toJson();
              // ignore: avoid_dynamic_calls
              data['createdAt'] = data['createdAt']?.millisecondsSinceEpoch;
              data['id'] = doc.id;
              // ignore: avoid_dynamic_calls
              data['updatedAt'] = data['updatedAt']?.millisecondsSinceEpoch;

              return [...previousValue, types.Message.fromJson(data)];
            },
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
