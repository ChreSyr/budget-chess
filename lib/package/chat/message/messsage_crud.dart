// ignore_for_file: comment_references

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crea_chess/package/chat/message/message_model.dart';
import 'package:crea_chess/package/firebase/firestore/crud/model_converter.dart';
import 'package:crea_chess/package/firebase/firestore/crud/sub_collection_crud.dart';
import 'package:crea_chess/package/firebase/firestore/relationship/relationship_crud.dart';

class _MessageModelConverter implements ModelConverter<MessageModel> {
  @override
  MessageModel fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? _,
  ) {
    return MessageModel.fromFirestore(snapshot);
  }

  @override
  Map<String, dynamic> toFirestore(MessageModel data, SetOptions? _) {
    return data.toFirestore();
  }
}

class _MessageCRUD extends SubCollectionCRUD<MessageModel> {
  _MessageCRUD()
      : super(
          relationshipCRUD.collectionName,
          'message',
          _MessageModelConverter(),
        );

  CollectionReference<Map<String, dynamic>> _collection(
    String relationshipId,
  ) =>
      FirebaseFirestore.instance.collection(
        '${relationshipCRUD.collectionName}/$relationshipId/$collectionName',
      );

  /// Sends a message to the Firestore. Accepts any partial message and a
  /// room ID. If arbitraty data is provided in the [partialMessage]
  /// does nothing.
  // Future<void> sendMessage(
  //   String senderId,
  //   String relationshipId, // TODO : receiverId
  //   dynamic partialMessage,
  // ) async {
  //   MessageModel? message;

  //   if (partialMessage is types.PartialCustom) {
  //     message = types.CustomMessage.fromPartial(
  //       authorId: senderId,
  //       id: '',
  //       partialCustom: partialMessage,
  //     );
  //   } else if (partialMessage is types.PartialFile) {
  //     message = types.FileMessage.fromPartial(
  //       authorId: senderId,
  //       id: '',
  //       partialFile: partialMessage,
  //     );
  //   } else if (partialMessage is types.PartialImage) {
  //     message = types.ImageMessage.fromPartial(
  //       authorId: senderId,
  //       id: '',
  //       partialImage: partialMessage,
  //     );
  //   } else if (partialMessage is types.PartialText) {
  //     message = types.TextMessage.fromPartial(
  //       authorId: senderId,
  //       id: '',
  //       partialText: partialMessage,
  //     );
  //   }

  //   message = message?.copyWith(
  //     createdAt: Timestamp.now().seconds,
  //     updatedAt: Timestamp.now().seconds,
  //   );

  //   if (message != null) {
  //     final messageMap = message.toJson()
  //       ..removeWhere((key, value) => key == 'id');
  //     // messageMap['createdAt'] = Timestamp.now();
  //     // messageMap['updatedAt'] = Timestamp.now();

  //     try {
  //       await _collection(relationshipId).add(messageMap);
  //       await updated(relationshipId);
  //     } catch (_) {
  //       // LATER : store locally non sent messages, allow to retry
  //       message = message.copyWith(status: MessageStatus.error);
  //       rethrow;
  //     }
  //   }
  // }

  /// Returns a stream of messages for a relation.
  Stream<List<MessageModel>> streamAll({
    required String relationshipId,
    List<Object?>? endAt,
    List<Object?>? endBefore,
    int? limit,
    List<Object?>? startAfter,
    List<Object?>? startAt,
  }) {
    var query =
        _collection(relationshipId).orderBy('createdAt', descending: true);

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
          (snapshot) => snapshot.docs.fold<List<MessageModel>>(
            [],
            (previousValue, doc) {
              final data = doc.data();
              // TODO : MessageModel.createdAt with Timestamp converter
              // ignore: avoid_dynamic_calls
              data['createdAt'] = data['createdAt']?.millisecondsSinceEpoch;
              data['id'] = doc.id;
              // ignore: avoid_dynamic_calls
              data['updatedAt'] = data['updatedAt']?.millisecondsSinceEpoch;

              return [...previousValue, MessageModel.fromJson(data)];
            },
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
