// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partial_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartialFile _$PartialFileFromJson(Map<String, dynamic> json) => PartialFile(
      name: json['name'] as String,
      size: json['size'] as num,
      uri: json['uri'] as String,
      metadata: json['metadata'] as Map<String, dynamic>?,
      mimeType: json['mimeType'] as String?,
      repliedMessage: json['repliedMessage'] == null
          ? null
          : MessageModel.fromJson(
              json['repliedMessage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PartialFileToJson(PartialFile instance) =>
    <String, dynamic>{
      'metadata': instance.metadata,
      'mimeType': instance.mimeType,
      'name': instance.name,
      'repliedMessage': instance.repliedMessage,
      'size': instance.size,
      'uri': instance.uri,
    };
