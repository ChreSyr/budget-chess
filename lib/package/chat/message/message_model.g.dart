// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageModelImpl _$$MessageModelImplFromJson(Map<String, dynamic> json) =>
    _$MessageModelImpl(
      id: json['id'] as String,
      createdAt: const TimestampToDateTimeConverter()
          .fromJson(json['createdAt'] as Timestamp?),
      updatedAt: const TimestampToDateTimeConverter()
          .fromJson(json['updatedAt'] as Timestamp?),
      authorId: json['authorId'] as String?,
      text: json['text'] as String?,
      showStatus: json['showStatus'] as bool? ?? true,
      status: $enumDecodeNullable(_$MessageStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$$MessageModelImplToJson(_$MessageModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt':
          const TimestampToDateTimeConverter().toJson(instance.createdAt),
      'updatedAt':
          const TimestampToDateTimeConverter().toJson(instance.updatedAt),
      'authorId': instance.authorId,
      'text': instance.text,
      'showStatus': instance.showStatus,
      'status': _$MessageStatusEnumMap[instance.status],
    };

const _$MessageStatusEnumMap = {
  MessageStatus.delivered: 'delivered',
  MessageStatus.error: 'error',
  MessageStatus.seen: 'seen',
  MessageStatus.sending: 'sending',
  MessageStatus.sent: 'sent',
};
