import 'package:crea_chess/package/firebase/export.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

/// All possible statuses message can have.
enum MessageSendStatus { error, sending, sent }

enum MessageSeenStatus {
  sentTo,
  delivered,
  seen;

  bool get unseen => this != seen;
}

@freezed
class MessageToUserStatus with _$MessageToUserStatus {
  factory MessageToUserStatus({
    DateTime? updatedAt,
    @Default(MessageSeenStatus.sentTo) MessageSeenStatus seenStatus,
  }) = _MessageToUserStatus;

  factory MessageToUserStatus.fromJson(Map<String, dynamic> json) =>
      _$MessageToUserStatusFromJson(json);
}

class MessageToUserStatusConverter
    implements JsonConverter<MessageToUserStatus, Map<String, dynamic>> {
  const MessageToUserStatusConverter();

  @override
  MessageToUserStatus fromJson(Map<String, dynamic> json) {
    return MessageToUserStatus.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(MessageToUserStatus data) => data.toJson();
}

@freezed
class MessageModel with _$MessageModel {
  factory MessageModel({
    required String relationshipId,
    required String id,
    required String authorId,
    required String text,
    @Default(MessageSendStatus.sent) MessageSendStatus sendStatus,
    DateTime? sentAt,
    @Default([]) List<String> sentTo,
    @Default([]) List<String> deliveredTo,
    @Default([]) List<String> seenBy,
  }) = _MessageModel;

  /// Required for the override getter
  const MessageModel._();

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  // --

  Map<String, MessageToUserStatus> get copyOfStatuses =>
      Map<String, MessageToUserStatus>.from(statuses);
  bool notSeenBy(String userId) => statuses[userId]?.seenStatus.unseen == true;
  MessageSeenStatus? seenStatusOf(String userId) =>
      statuses[userId]?.seenStatus;
  MessageSeenStatus get globalSeenStatus {
    MessageSeenStatus? globalStatus;
    for (final seenStatus in statuses.values.map((e) => e.seenStatus)) {
      switch (seenStatus) {
        case MessageSeenStatus.sentTo:
          return MessageSeenStatus.sentTo;
        case MessageSeenStatus.delivered:
          globalStatus = MessageSeenStatus.delivered;
        case MessageSeenStatus.seen:
          continue;
      }
    }
    return globalStatus ?? MessageSeenStatus.seen;
  }

  bool get isFromSystem => id == SystemMessage.id;

  MessageModel copyWithSeenStatus({
    required String userId,
    required MessageSeenStatus seenStatus,
  }) {
    return copyWith(
      statuses: copyOfStatuses
        ..[userId] = MessageToUserStatus(
          updatedAt: DateTime.now(),
          seenStatus: seenStatus,
        ),
    );
  }
}
