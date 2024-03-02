import 'dart:async';

import 'package:crea_chess/package/chessground/export.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/firebase/firestore/game/game/game.dart';
import 'package:crea_chess/package/firebase/firestore/game/live_game/game_indb.dart';
import 'package:crea_chess/package/unichess/unichess.dart';
import 'package:crea_chess/route/hub/game/game_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameCubit extends Cubit<GameState?> {
  GameCubit({required this.gameId}) : super(null) {
    _gameStream = liveGameCRUD.stream(documentId: gameId).listen(
          (game) => game == null
              ? emit(null)
              : emit(GameState(game: game, stepCursor: game.steps.length)),
        );
  }

  late final String gameId;
  late StreamSubscription<GameModel?> _gameStream;

  @override
  Future<void> close() {
    _gameStream.cancel();
    return super.close();
  }

  // ---

  bool startEndAnimation = false; // TODO : remove ?

  Future<void> submitSetup(SetupModel setup, {required Side forSide}) async {
    var game = state?.game;
    if (game == null) return;

    game = switch (forSide) {
      Side.white => game.copyWith(whiteSetupFen: setup.fenAs(forSide)),
      Side.black => game.copyWith(blackSetupFen: setup.fenAs(forSide)),
    };

    if (game.blackSetupFen != null && game.whiteSetupFen != null) {
      game = game.copyWith(
        status: GameStatus.started,
        steps: [
          GameStep(
            position: Position.setupPosition(
              game.challenge.rule,
              Setup.fromHalfSetups(
                size: game.challenge.boardSize,
                whiteSetupFen: game.whiteSetupFen,
                blackSetupFen: game.blackSetupFen,
              ),
            ),
          ),
        ],
      );
    }

    await liveGameCRUD.update(
      documentId: game.id,
      data: game,
    );

    return emit(
      state?.copyWith(game: game),
    );
  }

  void onCGMove(CGMove move, {bool? isDrop, bool? isPremove}) {
    final m = Move.fromUci(
      move.uci,
      state?.position?.board.size ?? BoardSize.standard,
    );
    if (m == null) return;

    onMove(m);
  }

  Future<void> onMove(Move move) async {
    final oldState = state;
    if (oldState == null) return;

    final oldPosition = oldState.position;

    // the game didn't start yet
    if (oldPosition == null) return;

    final san = oldPosition.makeSanUnchecked(move).$2;
    final position = oldPosition.playUnchecked(move);

    final GameStatus status;
    if (position.isCheckmate) {
      status = GameStatus.mate;
    } else if (position.isStalemate) {
      status = GameStatus.stalemate;
    } else if (position.isInsufficientMaterial) {
      status = GameStatus.draw;
    } else if (position.isVariantEnd) {
      status = GameStatus.variantEnd;
    } else {
      status = oldState.game.status;
    }

    if (status.value > GameStatus.aborted.value) startEndAnimation = true;

    final game = oldState.game.copyWith(
      steps: List.from(oldState.game.steps)
        ..add(
          GameStep(
            sanMove: SanMove(san, move),
            position: position,
            diff: MaterialDiff.fromBoard(position.board),
          ),
        ),
      status: status,
      winner:
          status == GameStatus.mate ? oldPosition.turn : oldState.game.winner,
    );

    await liveGameCRUD.update(
      documentId: game.id,
      data: game,
    );

    return emit(
      oldState.copyWith(
        game: game,
        stepCursor: oldState.stepCursor + 1,
      ),
    );
  }

  void onPremove(CGMove? premove) => emit(state?.copyWith(premove: premove));

  void resetEndAnimation() {
    startEndAnimation = false;
  }
}
