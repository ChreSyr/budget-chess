// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_indb.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GamePrefsImpl _$$GamePrefsImplFromJson(Map<String, dynamic> json) =>
    _$GamePrefsImpl(
      showRatings: json['showRatings'] as bool,
      enablePremove: json['enablePremove'] as bool,
      autoQueen: $enumDecode(_$AutoQueenEnumMap, json['autoQueen']),
      zenMode: $enumDecode(_$ZenEnumMap, json['zenMode']),
    );

Map<String, dynamic> _$$GamePrefsImplToJson(_$GamePrefsImpl instance) =>
    <String, dynamic>{
      'showRatings': instance.showRatings,
      'enablePremove': instance.enablePremove,
      'autoQueen': _$AutoQueenEnumMap[instance.autoQueen]!,
      'zenMode': _$ZenEnumMap[instance.zenMode]!,
    };

const _$AutoQueenEnumMap = {
  AutoQueen.never: 'never',
  AutoQueen.premove: 'premove',
  AutoQueen.always: 'always',
};

const _$ZenEnumMap = {
  Zen.no: 'no',
  Zen.yes: 'yes',
  Zen.gameAuto: 'gameAuto',
};

_$GameInDBImpl _$$GameInDBImplFromJson(Map<String, dynamic> json) =>
    _$GameInDBImpl(
      id: json['id'] as String?,
      challenge: _$JsonConverterFromJson<Map<String, dynamic>, ChallengeModel>(
          json['challenge'], const ChallengeModelConverter().fromJson),
      blackId: json['blackId'] as String?,
      whiteId: json['whiteId'] as String?,
      status: $enumDecodeNullable(_$GameStatusEnumMap, json['status']),
      blackHalfFen: json['blackHalfFen'] as String?,
      whiteHalfFen: json['whiteHalfFen'] as String?,
      sanMoves: json['sanMoves'] as String?,
      winner: $enumDecodeNullable(_$SideEnumMap, json['winner']),
      prefs: _$JsonConverterFromJson<Map<String, dynamic>, GamePrefs>(
          json['prefs'], const GamePrefsConverter().fromJson),
    );

Map<String, dynamic> _$$GameInDBImplToJson(_$GameInDBImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'challenge': _$JsonConverterToJson<Map<String, dynamic>, ChallengeModel>(
          instance.challenge, const ChallengeModelConverter().toJson),
      'blackId': instance.blackId,
      'whiteId': instance.whiteId,
      'status': _$GameStatusEnumMap[instance.status],
      'blackHalfFen': instance.blackHalfFen,
      'whiteHalfFen': instance.whiteHalfFen,
      'sanMoves': instance.sanMoves,
      'winner': _$SideEnumMap[instance.winner],
      'prefs': _$JsonConverterToJson<Map<String, dynamic>, GamePrefs>(
          instance.prefs, const GamePrefsConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

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

const _$SideEnumMap = {
  Side.white: 'white',
  Side.black: 'black',
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
