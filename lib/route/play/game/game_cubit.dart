import 'dart:async';

import 'package:crea_chess/package/chessground/export.dart';
import 'package:crea_chess/package/dartchess/export.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/firebase/firestore/game/game/game.dart';
import 'package:crea_chess/package/firebase/firestore/game/live_game/game_indb.dart';
import 'package:crea_chess/route/play/game/game_state.dart';
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
    final oldState = state;
    if (oldState == null) return;

    final GameModel game;

    final whiteHalfFen = forSide == Side.white
        ? setup.halfFenAs(forSide)
        : oldState.game.whiteHalfFen;
    final blackHalfFen = forSide == Side.black
        ? setup.halfFenAs(forSide)
        : oldState.game.blackHalfFen;

    if (blackHalfFen == null || whiteHalfFen == null) {
      game = oldState.game.copyWith(
        whiteHalfFen: whiteHalfFen,
        blackHalfFen: blackHalfFen,
      );
    } else {
      final board = Board.parseFen(
        '${blackHalfFen.split('').reversed.join()}/$whiteHalfFen',
      );

      game = oldState.game.copyWith(
        whiteHalfFen: whiteHalfFen,
        blackHalfFen: blackHalfFen,
        status: GameStatus.started,
        steps: [
          GameStep(
            position: Position.setupPosition(
              oldState.game.challenge.rule,
              Setup(
                board: board,
                turn: Side.white,
                unmovedRooks: board.rooks,
                halfmoves: 0,
                fullmoves: 0,
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
      oldState.copyWith(game: game),
    );
  }

  void onCGMove(CGMove move, {bool? isDrop, bool? isPremove}) {
    final m = Move.fromUci(move.uci);
    if (m == null) return;

    onMove(m);
  }

  void onMove(Move move) {
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

    emit(
      oldState.copyWith(
        game: oldState.game.copyWith(
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
              status == GameStatus.mate
              ? oldPosition.turn
              : oldState.game.winner,
        ),
        stepCursor: oldState.stepCursor + 1,
      ),
    );
  }

  void onPremove(CGMove? premove) => emit(state?.copyWith(premove: premove));

  void resetEndAnimation() {
    startEndAnimation = false;
  }
}
