// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChallengeModelImpl _$$ChallengeModelImplFromJson(Map<String, dynamic> json) =>
    _$ChallengeModelImpl(
      id: json['id'] as String,
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
      boardSizeProtected:
          _$JsonConverterFromJson<Map<String, dynamic>, BoardSize>(
              json['boardSizeProtected'], const BoardSizeConverter().fromJson),
      budget: json['budget'] as int? ?? 39,
    );

Map<String, dynamic> _$$ChallengeModelImplToJson(
        _$ChallengeModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'acceptedAt': instance.acceptedAt?.toIso8601String(),
      'authorId': instance.authorId,
      'rule': _$RuleEnumMap[instance.rule]!,
      'time': instance.time,
      'increment': instance.increment,
      'boardSizeProtected':
          _$JsonConverterToJson<Map<String, dynamic>, BoardSize>(
              instance.boardSizeProtected, const BoardSizeConverter().toJson),
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

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
