// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_filter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChallengeSorterStateImpl _$$ChallengeSorterStateImplFromJson(
        Map<String, dynamic> json) =>
    _$ChallengeSorterStateImpl(
      userId: json['userId'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
      speed: (json['speed'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$SpeedEnumMap, e))
              .toSet() ??
          const {Speed.bullet, Speed.blitz, Speed.rapid, Speed.classical},
      budgetAsc: json['budgetAsc'] as bool? ?? true,
    );

Map<String, dynamic> _$$ChallengeSorterStateImplToJson(
        _$ChallengeSorterStateImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'id': instance.id,
      'name': instance.name,
      'speed': instance.speed.map((e) => _$SpeedEnumMap[e]!).toList(),
      'budgetAsc': instance.budgetAsc,
    };

const _$SpeedEnumMap = {
  Speed.bullet: 'bullet',
  Speed.blitz: 'blitz',
  Speed.rapid: 'rapid',
  Speed.classical: 'classical',
};
