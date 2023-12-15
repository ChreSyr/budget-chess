// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChallengeModelImpl _$$ChallengeModelImplFromJson(Map<String, dynamic> json) =>
    _$ChallengeModelImpl(
      id: json['id'] as String?,
      ref: json['ref'] as String?,
      creatorId: json['creatorId'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      time: json['time'] as int?,
      increment: json['increment'] as int?,
      boardWidth: json['boardWidth'] as int?,
      boardHeight: json['boardHeight'] as int?,
      budget: json['budget'] as int?,
    );

Map<String, dynamic> _$$ChallengeModelImplToJson(
        _$ChallengeModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ref': instance.ref,
      'creatorId': instance.creatorId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'time': instance.time,
      'increment': instance.increment,
      'boardWidth': instance.boardWidth,
      'boardHeight': instance.boardHeight,
      'budget': instance.budget,
    };
