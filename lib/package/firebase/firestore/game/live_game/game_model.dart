import 'package:crea_chess/package/dartchess/export.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/firebase/firestore/game/game/game.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_model.freezed.dart';
// part 'game_model.g.dart';

/// Represents a game being currently played
@freezed
class GameModel with _$GameModel {
  const factory GameModel({
    required String id,
    required ChallengeModel challenge,
    required String blackId,
    required String whiteId,
    required GameStatus status,

    /// Starting position of black pieces.
    /// null means black is seting up its pieces.
    String? blackHalfFen,

    /// Starting position of white pieces.
    /// null means white is seting up its pieces.
    String? whiteHalfFen,
    @Default([]) List<GameStep> steps,
    Side? winner, // if status is ended & winner is null : draw
  }) = _GameModel;

  /// Required for the override getter
  const GameModel._();

  // factory GameModel.fromJson(Map<String, dynamic> json) =>
  //     _$GameModelFromJson(json);

  // ---

  // Position get position {
  //   final fen = currentFen ??
  //       '${blackHalfFen?.split('').reversed.join() ?? '8/8/8/8'}/${whiteHalfFen ?? '8/8/8/8'}';

  //   final board = Board.parseFen(fen);

  //   return Position.setupPosition(
  //     challenge.rule,
  //     Setup(
  //       board: board,
  //       turn: moves.length.isEven ? Side.white : Side.black,
  //       unmovedRooks: board.rooks,
  //       halfmoves: 0,
  //       fullmoves: 0,
  //     ),
  //   );
  // }

  Position? get lastPosition => steps.lastOrNull?.position;
}
