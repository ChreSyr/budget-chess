import 'package:crea_chess/package/chessground/export.dart';
import 'package:crea_chess/package/dartchess/export.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/firebase/firestore/game/game/game.dart';
import 'package:crea_chess/package/firebase/firestore/game/live_game/game_indb.dart';
import 'package:crea_chess/route/play/game/game_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit(super.initialState);

  bool startEndAnimation = false;

  void submitSetup(SetupModel setup, {required Side forSide}) {
    // TODO : rework
    final whiteHalfFen = forSide == Side.white
        ? setup.halfFenAs(forSide)
        : state.game.whiteHalfFen;
    final blackHalfFen = forSide == Side.black
        ? setup.halfFenAs(forSide)
        : state.game.blackHalfFen;

    final board = Board.parseFen(
      '${blackHalfFen?.split('').reversed.join() ?? '8/8/8/8'}/${whiteHalfFen ?? '8/8/8/8'}',
    );

    emit(
      state.copyWith(
        game: state.game.copyWith(
          whiteHalfFen: whiteHalfFen,
          blackHalfFen: blackHalfFen,
          status: GameStatus.started,
          steps: [
            GameStep(
              position: Position.setupPosition(
                state.game.challenge.rule,
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
        ),
      ),
    );
  }

  void onCGMove(CGMove move, {bool? isDrop, bool? isPremove}) {
    final m = Move.fromUci(move.uci);
    if (m == null) return;

    onMove(m);
  }

  void onMove(Move move) {
    final oldPosition = state.position;

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
      status = state.game.status;
    }

    if (status.value > GameStatus.aborted.value) startEndAnimation = true;

    emit(
      state.copyWith(
        game: state.game.copyWith(
          steps: List.from(state.game.steps)
            ..add(
              GameStep(
                sanMove: SanMove(san, move),
                position: position,
                diff: MaterialDiff.fromBoard(position.board),
              ),
            ),
          status: status,
          winner:
              status == GameStatus.mate ? oldPosition.turn : state.game.winner,
        ),
        stepCursor: state.stepCursor + 1,
      ),
    );
  }

  void onPremove(CGMove? premove) => emit(state.copyWith(premove: premove));

  void resetEndAnimation() {
    startEndAnimation = false;
  }
}
