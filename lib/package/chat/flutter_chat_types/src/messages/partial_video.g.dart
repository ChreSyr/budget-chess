// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partial_video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartialVideo _$PartialVideoFromJson(Map<String, dynamic> json) => PartialVideo(
      name: json['name'] as String,
      size: json['size'] as num,
      uri: json['uri'] as String,
      height: (json['height'] as num?)?.toDouble(),
      metadata: json['metadata'] as Map<String, dynamic>?,
      repliedMessage: json['repliedMessage'] == null
          ? null
          : MessageModel.fromJson(
              json['repliedMessage'] as Map<String, dynamic>),
      width: (json['width'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PartialVideoToJson(PartialVideo instance) =>
    <String, dynamic>{
      'height': instance.height,
      'metadata': instance.metadata,
      'name': instance.name,
      'repliedMessage': instance.repliedMessage,
      'size': instance.size,
      'uri': instance.uri,
      'width': instance.width,
    };
