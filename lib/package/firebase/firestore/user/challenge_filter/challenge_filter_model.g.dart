// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_filter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChallengeSorterStateImpl _$$ChallengeSorterStateImplFromJson(
        Map<String, dynamic> json) =>
    _$ChallengeSorterStateImpl(
      userId: json['userId'] as String? ?? ChallengeFilterModel._local,
      id: json['id'] as String? ?? ChallengeFilterModel._local,
      speeds: (json['speeds'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$SpeedEnumMap, e))
              .toSet() ??
          const {Speed.bullet, Speed.blitz, Speed.rapid, Speed.classical},
      rules: (json['rules'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$RuleEnumMap, e))
              .toSet() ??
          const {Rule.chess},
    );

Map<String, dynamic> _$$ChallengeSorterStateImplToJson(
        _$ChallengeSorterStateImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'id': instance.id,
      'speeds': instance.speeds.map((e) => _$SpeedEnumMap[e]!).toList(),
      'rules': instance.rules.map((e) => _$RuleEnumMap[e]!).toList(),
    };

const _$SpeedEnumMap = {
  Speed.bullet: 'bullet',
  Speed.blitz: 'blitz',
  Speed.rapid: 'rapid',
  Speed.classical: 'classical',
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
