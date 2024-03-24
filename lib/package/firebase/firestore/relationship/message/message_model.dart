import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

/// All possible statuses message can have.
enum MessageStatus { delivered, error, seen, sending, sent }

@freezed
class MessageModel with _$MessageModel {
  factory MessageModel({
    required String relationshipId,
    required String id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? authorId,
    String? text,
    MessageStatus? status,
  }) = _MessageModel;

  /// Creates a full text message from a partial one.
  factory MessageModel.fromText({
    required String relationshipId,
    required String authorId,
    required String text,
  }) =>
      MessageModel(
        relationshipId: relationshipId,
        id: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        authorId: authorId,
        text: text,
        status: MessageStatus.sending,
      );

  /// Required for the override getter
  const MessageModel._();

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
}
