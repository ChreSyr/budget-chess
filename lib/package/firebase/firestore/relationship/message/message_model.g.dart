// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageToUserStatusImpl _$$MessageToUserStatusImplFromJson(
        Map<String, dynamic> json) =>
    _$MessageToUserStatusImpl(
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      seenStatus:
          $enumDecodeNullable(_$MessageSeenStatusEnumMap, json['seenStatus']) ??
              MessageSeenStatus.sentTo,
    );

Map<String, dynamic> _$$MessageToUserStatusImplToJson(
        _$MessageToUserStatusImpl instance) =>
    <String, dynamic>{
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'seenStatus': _$MessageSeenStatusEnumMap[instance.seenStatus]!,
    };

const _$MessageSeenStatusEnumMap = {
  MessageSeenStatus.sentTo: 'sentTo',
  MessageSeenStatus.delivered: 'delivered',
  MessageSeenStatus.seen: 'seen',
};

_$MessageModelImpl _$$MessageModelImplFromJson(Map<String, dynamic> json) =>
    _$MessageModelImpl(
      relationshipId: json['relationshipId'] as String,
      id: json['id'] as String,
      authorId: json['authorId'] as String,
      text: json['text'] as String,
      sentAt: json['sentAt'] == null
          ? null
          : DateTime.parse(json['sentAt'] as String),
      sendStatus:
          $enumDecodeNullable(_$MessageSendStatusEnumMap, json['sendStatus']) ??
              MessageSendStatus.sent,
      statuses: (json['statuses'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
                k,
                const MessageToUserStatusConverter()
                    .fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
    );

Map<String, dynamic> _$$MessageModelImplToJson(_$MessageModelImpl instance) =>
    <String, dynamic>{
      'relationshipId': instance.relationshipId,
      'id': instance.id,
      'authorId': instance.authorId,
      'text': instance.text,
      'sentAt': instance.sentAt?.toIso8601String(),
      'sendStatus': _$MessageSendStatusEnumMap[instance.sendStatus]!,
      'statuses': instance.statuses.map((k, e) =>
          MapEntry(k, const MessageToUserStatusConverter().toJson(e))),
    };

const _$MessageSendStatusEnumMap = {
  MessageSendStatus.error: 'error',
  MessageSendStatus.sending: 'sending',
  MessageSendStatus.sent: 'sent',
};
