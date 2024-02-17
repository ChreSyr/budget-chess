// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameModelImpl _$$GameModelImplFromJson(Map<String, dynamic> json) =>
    _$GameModelImpl(
      id: json['id'] as String,
      challenge:
          ChallengeModel.fromJson(json['challenge'] as Map<String, dynamic>),
      blackId: json['blackId'] as String,
      whiteId: json['whiteId'] as String,
      status: $enumDecode(_$GameStatusEnumMap, json['status']),
      blackHalfFen: json['blackHalfFen'] as String?,
      whiteHalfFen: json['whiteHalfFen'] as String?,
      moves:
          (json['moves'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      winner: $enumDecodeNullable(_$SideEnumMap, json['winner']),
    );

Map<String, dynamic> _$$GameModelImplToJson(_$GameModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'challenge': instance.challenge,
      'blackId': instance.blackId,
      'whiteId': instance.whiteId,
      'status': _$GameStatusEnumMap[instance.status]!,
      'blackHalfFen': instance.blackHalfFen,
      'whiteHalfFen': instance.whiteHalfFen,
      'moves': instance.moves,
      'winner': _$SideEnumMap[instance.winner],
    };

const _$GameStatusEnumMap = {
  GameStatus.unknown: 'unknown',
  GameStatus.setup: 'setup',
  GameStatus.created: 'created',
  GameStatus.started: 'started',
  GameStatus.aborted: 'aborted',
  GameStatus.mate: 'mate',
  GameStatus.resign: 'resign',
  GameStatus.stalemate: 'stalemate',
  GameStatus.timeout: 'timeout',
  GameStatus.draw: 'draw',
  GameStatus.outoftime: 'outoftime',
  GameStatus.cheat: 'cheat',
  GameStatus.noStart: 'noStart',
  GameStatus.unknownFinish: 'unknownFinish',
  GameStatus.variantEnd: 'variantEnd',
};

const _$SideEnumMap = {
  Side.white: 'white',
  Side.black: 'black',
};
