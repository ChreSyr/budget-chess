import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/firebase/firestore/crud/sub_collection_crud.dart';

class _MessageCRUD extends SubCollectionCRUD<MessageModel> {
  _MessageCRUD()
      : super(
          parentCollectionName: relationshipCRUD.collectionName,
          collectionName: 'message',
        );

  @override
  MessageModel? jsonToModel(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? _,
  ) {
    try {
      final json = snapshot.data() ?? {};
      json['relationshipId'] = snapshot.reference.parent.parent?.id ?? '';
      json['id'] = snapshot.id;
      return MessageModel.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, Object?> modelToJson(MessageModel? data, SetOptions? _) {
    return (data?.toJson()
          ?..removeWhere(
            (key, value) =>
                key == 'relationshipId' || key == 'id' || value == null,
          )) ??
        {};
  }

  CollectionReference<Map<String, dynamic>> _collection(
    String relationshipId,
  ) =>
      FirebaseFirestore.instance.collection(
        '${relationshipCRUD.collectionName}/$relationshipId/$collectionName',
      );

  Stream<Iterable<MessageModel>> messagesUnreadBy(String userId) {
    return streamGroupFiltered(
      filter: (query) => query.where(
        Filter.or(
          Filter(MessageSeenStatus.sentTo.name, arrayContains: userId),
          Filter(MessageSeenStatus.delivered.name, arrayContains: userId),
        ),
      ),
    );
  }

  Future<void> onFriendshipStart({required RelationshipModel friendship}) =>
      create(
        parentDocumentId: friendship.id,
        data: SystemMessage.atFriendshipStart(friendship: friendship),
      );

  Future<void> updated(String relationshipId) async {
    await _collection(relationshipId)
        .doc(relationshipId)
        .update({'updatedAt': Timestamp.now()});
  }

  Future<void> updateSeenStatus({
    required MessageModel message,
    required String userId,
    required MessageSeenStatus seenStatus,
  }) =>
      update(
      parentDocumentId: message.relationshipId,
      documentId: message.id,
        data: message.copyWithSeenStatus(
          userId: userId,
          seenStatus: seenStatus,
        ),
      );
}

final messageCRUD = _MessageCRUD();
