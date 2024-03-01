import 'package:crea_chess/package/unichess/unichess.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/firebase/firestore/game/game/game.dart';
import 'package:crea_chess/package/firebase/firestore/game/live_game/game_indb.dart';
import 'package:flutter/material.dart';
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
    String? blackSetupFen,

    /// Starting position of white pieces.
    /// null means white is seting up its pieces.
    String? whiteSetupFen,
    @Default([]) List<GameStep> steps,
    Side? winner, // if status is ended & winner is null : draw
    GamePrefs? prefs,
  }) = _GameModel;

  /// Required for the override getter
  const GameModel._();

  static GameModel? fromDB(GameInDB game) {
    try {
      List<GameStep> steps;
      try {
        var position = Position.setupPosition(
          game.challenge!.rule,
          Setup.fromHalfSetups(
            size: game.challenge!.boardSize,
            blackSetupFen: game.blackSetupFen,
            whiteSetupFen: game.whiteSetupFen,
          ),
        );
        steps = [GameStep(position: position)];

        if (game.sanMoves!.isNotEmpty) {
          for (final san in game.sanMoves!.split(' ')) {
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
        id: game.id!,
        challenge: game.challenge!,
        blackId: game.blackId!,
        whiteId: game.whiteId!,
        status: game.status!,
        blackSetupFen: game.blackSetupFen,
        whiteSetupFen: game.whiteSetupFen,
        steps: steps,
        winner: game.winner,
        prefs: game.prefs,
      );
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  GameInDB toDB() {
    return GameInDB(
      id: id,
      challenge: challenge,
      blackId: blackId,
      whiteId: whiteId,
      status: status,
      blackSetupFen: blackSetupFen,
      whiteSetupFen: whiteSetupFen,
      sanMoves: steps.map((e) => e.sanMove?.san).whereType<String>().join(' '),
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
        Side.white => whiteSetupFen != null && whiteSetupFen!.isNotEmpty,
        Side.black => blackSetupFen != null && blackSetupFen!.isNotEmpty,
      };

  Side? sideOf(String playerId) {
    if (playerId == whiteId) return Side.white;
    if (playerId == blackId) return Side.black;
    return null;
  }
}
