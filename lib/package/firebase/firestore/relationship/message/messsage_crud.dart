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
          )
          ..addAll({'receiverId': data?.receiverId})) ??
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
        Filter.and(
          Filter('receiverId', isEqualTo: userId),
          Filter.or(
            Filter('status', isEqualTo: MessageStatus.sent.name),
            Filter('status', isEqualTo: MessageStatus.delivered.name),
          ),
        ),
      ),
    );
  }

  Future<void> updated(String relationshipId) async {
    await _collection(relationshipId)
        .doc(relationshipId)
        .update({'updatedAt': Timestamp.now()});
  }
}

final messageCRUD = _MessageCRUD();
