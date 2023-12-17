// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageModelImpl _$$MessageModelImplFromJson(Map<String, dynamic> json) =>
    _$MessageModelImpl(
      id: json['id'] as String?,
      ref: json['ref'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      authorId: json['authorId'] as String?,
      type: $enumDecodeNullable(_$MessageTypeEnumMap, json['type']),
      text: json['text'] as String?,
    );

Map<String, dynamic> _$$MessageModelImplToJson(_$MessageModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ref': instance.ref,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'authorId': instance.authorId,
      'type': _$MessageTypeEnumMap[instance.type],
      'text': instance.text,
    };

const _$MessageTypeEnumMap = {
  MessageType.text: 'text',
};
