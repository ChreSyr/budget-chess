// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_filter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChallengeSorterStateImpl _$$ChallengeSorterStateImplFromJson(
        Map<String, dynamic> json) =>
    _$ChallengeSorterStateImpl(
      id: json['id'] as String?,
      speed: (json['speed'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$SpeedEnumMap, e))
              .toSet() ??
          const {},
      budgetAsc: json['budgetAsc'] as bool? ?? true,
    );

Map<String, dynamic> _$$ChallengeSorterStateImplToJson(
        _$ChallengeSorterStateImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'speed': instance.speed.map((e) => _$SpeedEnumMap[e]!).toList(),
      'budgetAsc': instance.budgetAsc,
    };

const _$SpeedEnumMap = {
  Speed.bullet: 'bullet',
  Speed.blitz: 'blitz',
  Speed.rapid: 'rapid',
  Speed.classical: 'classical',
};
