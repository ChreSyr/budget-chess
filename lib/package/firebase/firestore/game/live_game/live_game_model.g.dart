// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_game_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LiveGameModelImpl _$$LiveGameModelImplFromJson(Map<String, dynamic> json) =>
    _$LiveGameModelImpl(
      id: json['id'] as String,
      challenge:
          ChallengeModel.fromJson(json['challenge'] as Map<String, dynamic>),
      blackId: json['blackId'] as String,
      whiteId: json['whiteId'] as String,
      status: $enumDecode(_$GameStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$$LiveGameModelImplToJson(_$LiveGameModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'challenge': instance.challenge,
      'blackId': instance.blackId,
      'whiteId': instance.whiteId,
      'status': _$GameStatusEnumMap[instance.status]!,
    };

const _$GameStatusEnumMap = {
  GameStatus.unknown: 'unknown',
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
