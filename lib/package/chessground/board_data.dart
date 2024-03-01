import 'package:crea_chess/package/chessground/models.dart';
import 'package:crea_chess/package/unichess/unichess.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/widgets.dart';

/// BoardWidget data.
///
/// Used to configure the board with state that will/may change during a game.
@immutable
class BoardData {
  const BoardData({
    required this.interactableSide,
    required this.orientation,
    required this.fen,
    this.sideToMove,
    this.premove,
    this.lastMove,
    this.validMoves,
    this.isCheck,
    this.shapes,
    this.annotations,
  }) : assert(
          (isCheck == null && interactableSide == InteractableSide.none) ||
              sideToMove != null,
          // ignore: lines_longer_than_80_chars
          'sideToMove must be set when isCheck is set, or when the board is interactable.',
        );

  /// Which color is allowed to move? It can be both, none, white or black
  ///
  /// If `none` is chosen the board will be non interactable.
  final InteractableSide interactableSide;

  /// Side by which the board is oriented.
  final Side orientation;

  /// Side which is to move.
  final Side? sideToMove;

  /// FEN string describing the position of the board.
  final String fen;

  /// Registered premove. Will be played right after the next opponent move.
  final CGMove? premove;

  /// Last move played, used to highlight corresponding squares.
  final CGMove? lastMove;

  /// Set of [CGMove] allowed to be played by current side to move.
  final ValidMoves? validMoves;

  /// Highlight the king of current side to move
  final bool? isCheck;

  /// Optional set of [Shape] to be drawn on the board.
  final ISet<Shape>? shapes;

  /// CGMove annotations to be displayed on the board.
  final IMap<SquareId, Annotation>? annotations;
}
