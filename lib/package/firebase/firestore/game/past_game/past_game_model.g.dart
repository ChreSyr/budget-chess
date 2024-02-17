// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'past_game_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PastGameModelImpl _$$PastGameModelImplFromJson(Map<String, dynamic> json) =>
    _$PastGameModelImpl(
      id: json['id'] as String,
      challenge:
          ChallengeModel.fromJson(json['challenge'] as Map<String, dynamic>),
      blackId: json['blackId'] as String,
      whiteId: json['whiteId'] as String,
      pgn: json['pgn'] as String,
      status: $enumDecode(_$GameStatusEnumMap, json['status']),
      winner: $enumDecodeNullable(_$SideEnumMap, json['winner']),
    );

Map<String, dynamic> _$$PastGameModelImplToJson(_$PastGameModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'challenge': instance.challenge,
      'blackId': instance.blackId,
      'whiteId': instance.whiteId,
      'pgn': instance.pgn,
      'status': _$GameStatusEnumMap[instance.status]!,
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
