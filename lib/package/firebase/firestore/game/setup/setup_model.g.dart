// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setup_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SetupModelImpl _$$SetupModelImplFromJson(Map<String, dynamic> json) =>
    _$SetupModelImpl(
      fen: json['fen'] as String,
      boardSizeProtected:
          _$JsonConverterFromJson<Map<String, dynamic>, BoardSize?>(
              json['boardSizeProtected'], const BoardSizeConverter().fromJson),
    );

Map<String, dynamic> _$$SetupModelImplToJson(_$SetupModelImpl instance) =>
    <String, dynamic>{
      'fen': instance.fen,
      'boardSizeProtected':
          const BoardSizeConverter().toJson(instance.boardSizeProtected),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);
