// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_sorter_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChallengeSorterStateImpl _$$ChallengeSorterStateImplFromJson(
        Map<String, dynamic> json) =>
    _$ChallengeSorterStateImpl(
      speed: $enumDecodeNullable(_$SpeedEnumMap, json['speed']),
      budgetAsc: json['budgetAsc'] as bool? ?? true,
    );

Map<String, dynamic> _$$ChallengeSorterStateImplToJson(
        _$ChallengeSorterStateImpl instance) =>
    <String, dynamic>{
      'speed': _$SpeedEnumMap[instance.speed],
      'budgetAsc': instance.budgetAsc,
    };

const _$SpeedEnumMap = {
  Speed.bullet: 'bullet',
  Speed.blitz: 'blitz',
  Speed.rapid: 'rapid',
  Speed.classical: 'classical',
};
