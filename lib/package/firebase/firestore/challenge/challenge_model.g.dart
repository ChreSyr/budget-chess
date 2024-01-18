// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChallengeModelImpl _$$ChallengeModelImplFromJson(Map<String, dynamic> json) =>
    _$ChallengeModelImpl(
      id: json['id'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      authorId: json['authorId'] as String?,
      status: $enumDecodeNullable(_$ChallengeStatusEnumMap, json['status']),
      time: json['time'] as int? ?? 180,
      increment: json['increment'] as int? ?? 2,
      boardWidth: json['boardWidth'] as int? ?? 8,
      boardHeight: json['boardHeight'] as int? ?? 8,
      budget: json['budget'] as int? ?? 39,
      userIds:
          (json['userIds'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$ChallengeModelImplToJson(
        _$ChallengeModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'authorId': instance.authorId,
      'status': _$ChallengeStatusEnumMap[instance.status],
      'time': instance.time,
      'increment': instance.increment,
      'boardWidth': instance.boardWidth,
      'boardHeight': instance.boardHeight,
      'budget': instance.budget,
      'userIds': instance.userIds,
    };

const _$ChallengeStatusEnumMap = {
  ChallengeStatus.open: 'open',
  ChallengeStatus.started: 'started',
  ChallengeStatus.finished: 'finished',
};
