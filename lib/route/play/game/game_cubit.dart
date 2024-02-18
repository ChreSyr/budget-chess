import 'package:crea_chess/package/chessground/export.dart';
import 'package:crea_chess/package/dartchess/export.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/firebase/firestore/game/game/game.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameCubit extends Cubit<GameModel> {
  GameCubit(super.initialState);

  void submitSetup(SetupModel setup, {required Side forSide}) {
    // TODO : rework
    final whiteHalfFen =
        forSide == Side.white ? setup.halfFenAs(forSide) : state.whiteHalfFen;
    final blackHalfFen =
        forSide == Side.black ? setup.halfFenAs(forSide) : state.blackHalfFen;

    final board = Board.parseFen(
      '${blackHalfFen?.split('').reversed.join() ?? '8/8/8/8'}/${whiteHalfFen ?? '8/8/8/8'}',
    );

    emit(
      state.copyWith(
        whiteHalfFen: whiteHalfFen,
        blackHalfFen: blackHalfFen,
        status: GameStatus.started,
        steps: [
          GameStep(
            position: Position.setupPosition(
              state.challenge.rule,
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
    );
  }

  void onCGMove(CGMove move, {bool? isDrop, bool? isPremove}) {
    final m = Move.fromUci(move.uci);
    if (m == null) return;

    onMove(m);
  }

  void onMove(Move move) {
    final oldPosition = state.lastPosition;

    // the game didn't start yet
    if (oldPosition == null) return;

    final san = oldPosition.makeSanUnchecked(move).$2;
    final position = oldPosition.playUnchecked(move);

    emit(
      state.copyWith(
        steps: List.from(state.steps)
          ..add(
            GameStep(
              sanMove: SanMove(san, move),
              position: position,
              diff: MaterialDiff.fromBoard(position.board),
            ),
          ),
      ),
    );
  }
}
