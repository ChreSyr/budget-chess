import 'package:crea_chess/package/chessground/board_theme.dart';
import 'package:crea_chess/package/chessground/freezed/draw_shape_options.dart';
import 'package:crea_chess/package/chessground/piece_set.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'board_settings.freezed.dart';
part 'board_settings.g.dart';

class OffsetConverter implements JsonConverter<Offset, Map<String, dynamic>> {
  const OffsetConverter();

  @override
  Offset fromJson(Map<String, dynamic> json) => Offset(
        json['dx'] as double,
        json['dy'] as double,
      );

  @override
  Map<String, dynamic> toJson(Offset offset) => {
        'dx': offset.dx,
        'dy': offset.dy,
      };
}

class DrawShapeOptionsConverter
    implements JsonConverter<DrawShapeOptions, Map<String, dynamic>> {
  const DrawShapeOptionsConverter();

  @override
  DrawShapeOptions fromJson(Map<String, dynamic> json) =>
      DrawShapeOptions.fromJson(json);

  @override
  Map<String, dynamic> toJson(DrawShapeOptions options) => options.toJson();
}

/// BoardWidget settings that control the theme, behavior and purpose of the
/// board.
///
/// This is meant for fixed settings that don't change during a game. Sensible
/// defaults are provided.
@freezed
class BoardSettings with _$BoardSettings {
  const factory BoardSettings({
    /// Theme of the board
    @Default(BoardTheme.brown1) BoardTheme boardTheme,

    /// Piece set
    @Default(PieceSet.frenzy) PieceSet pieceSet,

    /// Whether to show board coordinates
    @Default(true) bool enableCoordinates,

    /// Piece animation duration
    @Default(Duration(milliseconds: 250)) Duration animationDuration,

    /// Whether to show last move highlight
    @Default(true) bool showLastMove,

    /// Whether to show valid moves
    @Default(true) bool showValidMoves,

    /// Pieces are hidden in blindfold mode
    @Default(false) bool blindfoldMode,
    // Scale up factor for the piece currently under drag
    @Default(2.0) double dragFeedbackSize,
    // Offset for the piece currently under drag
    @OffsetConverter() @Default(Offset(0, -1)) Offset dragFeedbackOffset,

    /// Shape drawing options object containing data about how new shapes can be
    /// drawn.
    @DrawShapeOptionsConverter()
    @Default(DrawShapeOptions())
    DrawShapeOptions drawShape,

    /// Whether castling is enabled with a premove.
    @Default(true) bool enablePremoveCastling,

    /// If true the promotion selector won't appear and pawn will be promoted
    // automatically to queen
    @Default(false) bool autoQueenPromotion,

    /// If true the promotion selector won't appear and pawn will be promoted
    /// automatically to queen only if the premove is confirmed
    @Default(true) bool autoQueenPromotionOnPremove,
  }) = _BoardSettings;

  factory BoardSettings.fromJson(Map<String, dynamic> json) =>
      _$BoardSettingsFromJson(json);
}
