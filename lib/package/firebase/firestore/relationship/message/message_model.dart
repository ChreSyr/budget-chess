
import 'package:crea_chess/package/firebase/export.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

/// All possible statuses message can have.
enum MessageSendStatus { error, sending, sent }

enum MessageSeenStatus { sentTo, delivered, seen }

@freezed
class MessageModel with _$MessageModel {
  factory MessageModel({
    required String relationshipId,
    required String id,
    required String authorId,
    required String text,
    @Default(MessageSendStatus.sent) MessageSendStatus sendStatus,
    DateTime? sentAt,
    @Default({}) Set<String> sentTo,
    @Default({}) Set<String> deliveredTo,
    @Default({}) Set<String> seenBy,
  }) = _MessageModel;

  /// Required for the override getter
  const MessageModel._();

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  // --

  bool notSeenBy(String userId) => !seenBy.contains(userId);
  MessageSeenStatus get globalSeenStatus {
    return sentTo.isNotEmpty
        ? MessageSeenStatus.sentTo
        : deliveredTo.isNotEmpty
            ? MessageSeenStatus.delivered
            : MessageSeenStatus.seen;
  }

  bool get isFromSystem => authorId == SystemMessage.id;

  MessageModel copyWithSeenStatus({
    required String userId,
    required MessageSeenStatus seenStatus,
  }) {
    return copyWith(
      sentTo: seenStatus == MessageSeenStatus.sentTo
          ? (Set<String>.from(sentTo)..add(userId))
          : (Set<String>.from(sentTo)..remove(userId)),
      deliveredTo: seenStatus == MessageSeenStatus.delivered
          ? (Set<String>.from(deliveredTo)..add(userId))
          : (Set<String>.from(deliveredTo)..remove(userId)),
      seenBy: seenStatus == MessageSeenStatus.seen
          ? (Set<String>.from(seenBy)..add(userId))
          : (Set<String>.from(seenBy)..remove(userId)),
    );
  }
}
