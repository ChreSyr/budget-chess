import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crea_chess/package/chat/flutter_chat_types/src/message.dart';
import 'package:crea_chess/package/chat/flutter_chat_types/src/messages/partial_text.dart';
// import 'package:crea_chess/package/chat/flutter_chat_types/src/messages/partial_text.dart';
import 'package:crea_chess/package/chat/flutter_chat_types/src/preview_data.dart'
    show PreviewData;
import 'package:crea_chess/package/firebase/firestore/converter/timestamp_to_datetime.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
class MessageModel with _$MessageModel {
  factory MessageModel({
    String? id,
    @TimestampToDateTimeConverter() DateTime? createdAt,
    @TimestampToDateTimeConverter() DateTime? updatedAt,
    String? authorId,
    String? text,
    Map<String, dynamic>? metadata,
    PreviewData? previewData,
    String? remoteId,
    // MessageModel? repliedMessage,
    String? roomId,
    bool? showStatus,
    MessageStatus? status,
    MessageType? type,
    String? mediaName,
    num? mediaSize,
    double? mediaHeight,
    double? mediaWidth,
    String? uri,
  }) = _MessageModel;

  /// Creates a full text message from a partial one.
  factory MessageModel.fromPartialText({
    required String authorId,
    required PartialText partialText,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? remoteId,
    String? roomId,
    bool? showStatus,
    MessageStatus? status,
  }) =>
      MessageModel(
        id: id,
        createdAt: createdAt,
        updatedAt: updatedAt,
        authorId: authorId,
        text: partialText.text,
        metadata: partialText.metadata,
        previewData: partialText.previewData,
        remoteId: remoteId,
        // repliedMessage: partialText.repliedMessage,
        roomId: roomId,
        showStatus: showStatus,
        status: status,
        type: MessageType.text,
      );

  /// Required for the override getter
  const MessageModel._();

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
}
