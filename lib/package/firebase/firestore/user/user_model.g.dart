// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String?,
      ref: json['ref'] as String?,
      username: json['username'] as String?,
      usernameLowercase: json['usernameLowercase'] as String?,
      photo: json['photo'] as String?,
      banner: json['banner'] as String?,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ref': instance.ref,
      'username': instance.username,
      'usernameLowercase': instance.usernameLowercase,
      'photo': instance.photo,
      'banner': instance.banner,
    };
