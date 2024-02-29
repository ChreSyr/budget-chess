// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChallengeModelImpl _$$ChallengeModelImplFromJson(Map<String, dynamic> json) =>
    _$ChallengeModelImpl(
      id: json['id'] as String,
      boardSize: const BoardSizeConverter()
          .fromJson(json['boardSize'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      acceptedAt: json['acceptedAt'] == null
          ? null
          : DateTime.parse(json['acceptedAt'] as String),
      authorId: json['authorId'] as String?,
      rule: $enumDecodeNullable(_$RuleEnumMap, json['rule']) ?? Rule.chess,
      time: json['time'] as int? ?? 180,
      increment: json['increment'] as int? ?? 2,
      budget: json['budget'] as int? ?? 39,
    );

Map<String, dynamic> _$$ChallengeModelImplToJson(
        _$ChallengeModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'boardSize': const BoardSizeConverter().toJson(instance.boardSize),
      'createdAt': instance.createdAt?.toIso8601String(),
      'acceptedAt': instance.acceptedAt?.toIso8601String(),
      'authorId': instance.authorId,
      'rule': _$RuleEnumMap[instance.rule]!,
      'time': instance.time,
      'increment': instance.increment,
      'budget': instance.budget,
    };

const _$RuleEnumMap = {
  Rule.chess: 'chess',
  Rule.antichess: 'antichess',
  Rule.kingofthehill: 'kingofthehill',
  Rule.threecheck: 'threecheck',
  Rule.atomic: 'atomic',
  Rule.horde: 'horde',
  Rule.racingKings: 'racingKings',
  Rule.crazyhouse: 'crazyhouse',
};
