// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SanMoveImpl _$$SanMoveImplFromJson(Map<String, dynamic> json) =>
    _$SanMoveImpl(
      json['san'] as String,
      const MoveConverter().fromJson(json['move'] as String),
    );

Map<String, dynamic> _$$SanMoveImplToJson(_$SanMoveImpl instance) =>
    <String, dynamic>{
      'san': instance.san,
      'move': const MoveConverter().toJson(instance.move),
    };
