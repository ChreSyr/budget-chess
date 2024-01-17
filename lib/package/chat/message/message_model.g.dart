// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageModelImpl _$$MessageModelImplFromJson(Map<String, dynamic> json) =>
    _$MessageModelImpl(
      id: json['id'] as String?,
      createdAt: const TimestampToDateTimeConverter()
          .fromJson(json['createdAt'] as Timestamp?),
      updatedAt: const TimestampToDateTimeConverter()
          .fromJson(json['updatedAt'] as Timestamp?),
      authorId: json['authorId'] as String?,
      text: json['text'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      previewData: json['previewData'] == null
          ? null
          : PreviewData.fromJson(json['previewData'] as Map<String, dynamic>),
      remoteId: json['remoteId'] as String?,
      roomId: json['roomId'] as String?,
      showStatus: json['showStatus'] as bool?,
      status: $enumDecodeNullable(_$MessageStatusEnumMap, json['status']),
      type: $enumDecodeNullable(_$MessageTypeEnumMap, json['type']),
      mediaName: json['mediaName'] as String?,
      mediaSize: json['mediaSize'] as num?,
      mediaHeight: (json['mediaHeight'] as num?)?.toDouble(),
      mediaWidth: (json['mediaWidth'] as num?)?.toDouble(),
      uri: json['uri'] as String?,
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
      'metadata': instance.metadata,
      'previewData': instance.previewData,
      'remoteId': instance.remoteId,
      'roomId': instance.roomId,
      'showStatus': instance.showStatus,
      'status': _$MessageStatusEnumMap[instance.status],
      'type': _$MessageTypeEnumMap[instance.type],
      'mediaName': instance.mediaName,
      'mediaSize': instance.mediaSize,
      'mediaHeight': instance.mediaHeight,
      'mediaWidth': instance.mediaWidth,
      'uri': instance.uri,
    };

const _$MessageStatusEnumMap = {
  MessageStatus.delivered: 'delivered',
  MessageStatus.error: 'error',
  MessageStatus.seen: 'seen',
  MessageStatus.sending: 'sending',
  MessageStatus.sent: 'sent',
};

const _$MessageTypeEnumMap = {
  MessageType.audio: 'audio',
  MessageType.custom: 'custom',
  MessageType.file: 'file',
  MessageType.image: 'image',
  MessageType.system: 'system',
  MessageType.text: 'text',
  MessageType.unsupported: 'unsupported',
  MessageType.video: 'video',
};
