// ignore_for_file: public_member_api_docs, invalid_annotation_target

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

enum MessageType { text }

@freezed
class MessageModel with _$MessageModel {
  factory MessageModel({
    String? id,
    String? ref, // TODO : remove ?
    DateTime? createdAt, // date of friendship start
    DateTime? updatedAt, // TODO : reactions
    String? authorId,
    MessageType? type,
    String? text,
  }) = _MessageModel;

  /// Required for the override getter
  const MessageModel._();

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  factory MessageModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    return MessageModel.fromJson(doc.data() ?? {})
        .copyWith(id: doc.id, ref: doc.reference.path);
  }

  Map<String, dynamic> toFirestore() {
    return toJson()
      ..removeWhere((key, value) {
        return key == 'id' || key == 'ref' || value == null;
      });
  }
}
