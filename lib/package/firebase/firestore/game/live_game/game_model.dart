import 'package:crea_chess/package/dartchess/export.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/firebase/firestore/game/game/game.dart';
import 'package:crea_chess/package/firebase/firestore/game/live_game/game_indb.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_model.freezed.dart';

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
    GamePrefs? prefs,
  }) = _GameModel;

  /// Required for the override getter
  const GameModel._();

  GameInDB toGameInDB() {
    return GameInDB(
      id: id,
      challenge: challenge,
      blackId: blackId,
      whiteId: whiteId,
      status: status,
      blackHalfFen: blackHalfFen,
      whiteHalfFen: whiteHalfFen,
      sanMoves: steps.map((e) => e.sanMove?.san).join(' '),
      winner: winner,
      prefs: prefs,
    );
  }

  // ---

  bool get playable => status.value < GameStatus.aborted.value;
  bool get aborted => status == GameStatus.aborted;
  bool get finished => status.value >= GameStatus.mate.value;

  String playerId(Side side) => switch (side) {
        Side.white => whiteId,
        Side.black => blackId,
      };

  bool sideHasSetup(Side side) => switch (side) {
        Side.white => whiteHalfFen != null && whiteHalfFen!.isNotEmpty,
        Side.black => blackHalfFen != null && blackHalfFen!.isNotEmpty,
      };

  Side? sideOf(String playerId) {
    if (playerId == whiteId) return Side.white;
    if (playerId == blackId) return Side.black;
    return null;
  }
}

extension GameInDBExt on GameInDB {
  GameModel? toGameModel() {
    try {
      final board = Board.parseFen(
        '${blackHalfFen?.split('').reversed.join() ?? '8/8/8/8'}/${whiteHalfFen ?? '8/8/8/8'}',
      );
      List<GameStep> steps;
      try {
        var position = Position.setupPosition(
          challenge!.rule,
          Setup(
            board: board,
            turn: Side.white,
            unmovedRooks: board.rooks,
            halfmoves: 0,
            fullmoves: 0,
          ),
        );
        steps = [GameStep(position: position)];

        if (sanMoves!.isNotEmpty) {
          for (final san in sanMoves!.split(' ')) {
            final move = position.parseSan(san);
            // assume firestore only sends correct moves
            position = position.playUnchecked(move!);
            steps.add(
              GameStep(
                sanMove: SanMove(san, move),
                position: position,
                diff: MaterialDiff.fromBoard(position.board),
              ),
            );
          }
        }
      } on PositionError catch (_) {
        steps = [];
      }

      return GameModel(
        id: id!,
        challenge: challenge!,
        blackId: blackId!,
        whiteId: whiteId!,
        status: status!,
        blackHalfFen: blackHalfFen,
        whiteHalfFen: whiteHalfFen,
        steps: steps,
        winner: winner,
        prefs: prefs,
      );
    } catch (e) {
      print(e);
      return null;
    }
  }
}
