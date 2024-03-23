// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BoardSettingsImpl _$$BoardSettingsImplFromJson(Map<String, dynamic> json) =>
    _$BoardSettingsImpl(
      boardTheme:
          $enumDecodeNullable(_$BoardThemeEnumMap, json['boardTheme']) ??
              BoardTheme.brown1,
      pieceSet: $enumDecodeNullable(_$PieceSetEnumMap, json['pieceSet']) ??
          PieceSet.frenzy,
      enableCoordinates: json['enableCoordinates'] as bool? ?? true,
      animationDuration: json['animationDuration'] == null
          ? const Duration(milliseconds: 250)
          : Duration(microseconds: json['animationDuration'] as int),
      showLastMove: json['showLastMove'] as bool? ?? true,
      showValidMoves: json['showValidMoves'] as bool? ?? true,
      blindfoldMode: json['blindfoldMode'] as bool? ?? false,
      dragFeedbackSize: (json['dragFeedbackSize'] as num?)?.toDouble() ?? 2.0,
      dragFeedbackOffset: json['dragFeedbackOffset'] == null
          ? const Offset(0, -1)
          : const OffsetConverter()
              .fromJson(json['dragFeedbackOffset'] as Map<String, dynamic>),
      drawShape: json['drawShape'] == null
          ? const DrawShapeOptions()
          : const DrawShapeOptionsConverter()
              .fromJson(json['drawShape'] as Map<String, dynamic>),
      enablePremoveCastling: json['enablePremoveCastling'] as bool? ?? true,
      autoQueenPromotion: json['autoQueenPromotion'] as bool? ?? false,
      autoQueenPromotionOnPremove:
          json['autoQueenPromotionOnPremove'] as bool? ?? true,
    );

Map<String, dynamic> _$$BoardSettingsImplToJson(_$BoardSettingsImpl instance) =>
    <String, dynamic>{
      'boardTheme': _$BoardThemeEnumMap[instance.boardTheme]!,
      'pieceSet': _$PieceSetEnumMap[instance.pieceSet]!,
      'enableCoordinates': instance.enableCoordinates,
      'animationDuration': instance.animationDuration.inMicroseconds,
      'showLastMove': instance.showLastMove,
      'showValidMoves': instance.showValidMoves,
      'blindfoldMode': instance.blindfoldMode,
      'dragFeedbackSize': instance.dragFeedbackSize,
      'dragFeedbackOffset':
          const OffsetConverter().toJson(instance.dragFeedbackOffset),
      'drawShape': const DrawShapeOptionsConverter().toJson(instance.drawShape),
      'enablePremoveCastling': instance.enablePremoveCastling,
      'autoQueenPromotion': instance.autoQueenPromotion,
      'autoQueenPromotionOnPremove': instance.autoQueenPromotionOnPremove,
    };

const _$BoardThemeEnumMap = {
  BoardTheme.brown1: 'brown1',
  BoardTheme.brown2: 'brown2',
  BoardTheme.blue: 'blue',
  BoardTheme.blue2: 'blue2',
  BoardTheme.blue3: 'blue3',
  BoardTheme.blueMarble: 'blueMarble',
  BoardTheme.canvas: 'canvas',
  BoardTheme.wood: 'wood',
  BoardTheme.wood2: 'wood2',
  BoardTheme.wood3: 'wood3',
  BoardTheme.wood4: 'wood4',
  BoardTheme.maple: 'maple',
  BoardTheme.maple2: 'maple2',
  BoardTheme.leather: 'leather',
  BoardTheme.green: 'green',
  BoardTheme.marble: 'marble',
  BoardTheme.greenPlastic: 'greenPlastic',
  BoardTheme.grey: 'grey',
  BoardTheme.metal: 'metal',
  BoardTheme.olive: 'olive',
  BoardTheme.newspaper: 'newspaper',
  BoardTheme.purpleDiag: 'purpleDiag',
  BoardTheme.pinkPyramid: 'pinkPyramid',
  BoardTheme.horsey: 'horsey',
};

const _$PieceSetEnumMap = {
  PieceSet.frenzy: 'frenzy',
  PieceSet.cburnett: 'cburnett',
  PieceSet.merida: 'merida',
  PieceSet.pirouetti: 'pirouetti',
  PieceSet.chessnut: 'chessnut',
  PieceSet.chess7: 'chess7',
  PieceSet.alpha: 'alpha',
  PieceSet.reillycraig: 'reillycraig',
  PieceSet.companion: 'companion',
  PieceSet.riohacha: 'riohacha',
  PieceSet.kosal: 'kosal',
  PieceSet.leipzig: 'leipzig',
  PieceSet.fantasy: 'fantasy',
  PieceSet.spatial: 'spatial',
  PieceSet.celtic: 'celtic',
  PieceSet.california: 'california',
  PieceSet.caliente: 'caliente',
  PieceSet.pixel: 'pixel',
  PieceSet.maestro: 'maestro',
  PieceSet.fresca: 'fresca',
  PieceSet.cardinal: 'cardinal',
  PieceSet.gioco: 'gioco',
  PieceSet.tatiana: 'tatiana',
  PieceSet.staunty: 'staunty',
  PieceSet.governor: 'governor',
  PieceSet.dubrovny: 'dubrovny',
  PieceSet.icpieces: 'icpieces',
  PieceSet.libra: 'libra',
  PieceSet.mpchess: 'mpchess',
  PieceSet.shapes: 'shapes',
  PieceSet.kiwenSuwi: 'kiwenSuwi',
  PieceSet.horsey: 'horsey',
  PieceSet.anarcandy: 'anarcandy',
  PieceSet.letter: 'letter',
  PieceSet.disguised: 'disguised',
};
