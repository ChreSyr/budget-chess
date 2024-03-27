// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageModelImpl _$$MessageModelImplFromJson(Map<String, dynamic> json) =>
    _$MessageModelImpl(
      relationshipId: json['relationshipId'] as String,
      id: json['id'] as String,
      authorId: json['authorId'] as String,
      text: json['text'] as String,
      sendStatus:
          $enumDecodeNullable(_$MessageSendStatusEnumMap, json['sendStatus']) ??
              MessageSendStatus.sent,
      sentAt: json['sentAt'] == null
          ? null
          : DateTime.parse(json['sentAt'] as String),
      sentTo:
          (json['sentTo'] as List<dynamic>?)?.map((e) => e as String).toSet() ??
              const {},
      deliveredTo: (json['deliveredTo'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toSet() ??
          const {},
      seenBy:
          (json['seenBy'] as List<dynamic>?)?.map((e) => e as String).toSet() ??
              const {},
    );

Map<String, dynamic> _$$MessageModelImplToJson(_$MessageModelImpl instance) =>
    <String, dynamic>{
      'relationshipId': instance.relationshipId,
      'id': instance.id,
      'authorId': instance.authorId,
      'text': instance.text,
      'sendStatus': _$MessageSendStatusEnumMap[instance.sendStatus]!,
      'sentAt': instance.sentAt?.toIso8601String(),
      'sentTo': instance.sentTo.toList(),
      'deliveredTo': instance.deliveredTo.toList(),
      'seenBy': instance.seenBy.toList(),
    };

const _$MessageSendStatusEnumMap = {
  MessageSendStatus.error: 'error',
  MessageSendStatus.sending: 'sending',
  MessageSendStatus.sent: 'sent',
};
