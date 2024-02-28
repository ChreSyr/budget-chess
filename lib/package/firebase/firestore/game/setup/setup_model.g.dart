// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setup_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SetupModelImpl _$$SetupModelImplFromJson(Map<String, dynamic> json) =>
    _$SetupModelImpl(
      fen: json['fen'] as String,
      boardSize: const BoardSizeConverter()
          .fromJson(json['boardSize'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SetupModelImplToJson(_$SetupModelImpl instance) =>
    <String, dynamic>{
      'fen': instance.fen,
      'boardSize': const BoardSizeConverter().toJson(instance.boardSize),
    };
