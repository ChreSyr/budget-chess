// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      username: json['username'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      usernameLowercase: json['usernameLowercase'] as String?,
      photo: json['photo'] as String?,
      banner: json['banner'] as String?,
      isConnected: json['isConnected'] as bool? ?? false,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'createdAt': instance.createdAt?.toIso8601String(),
      'usernameLowercase': instance.usernameLowercase,
      'photo': instance.photo,
      'banner': instance.banner,
      'isConnected': instance.isConnected,
    };
