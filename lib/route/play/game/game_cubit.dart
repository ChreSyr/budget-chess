import 'package:chessground/chessground.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:dartchess_webok/dartchess_webok.dart' as dc;
import 'package:flutter_bloc/flutter_bloc.dart';

class GameCubit extends Cubit<GameModel> {
  GameCubit(super.initialState);

  void submitSetup(SetupModel setup, {required Side forSide}) {
    switch (forSide) {
      case Side.white:
        emit(
          state.copyWith(
            whiteHalfFen: setup.halfFenAs(forSide),
            status: GameStatus.started, // TODO : remove
          ),
        );
      case Side.black:
        emit(
          state.copyWith(
            blackHalfFen: setup.halfFenAs(forSide),
            status: GameStatus.started, // TODO : remove
          ),
        );
    }
  }

  void onMove(Move move, {bool? isDrop, bool? isPremove}) {
    final m = dc.Move.fromUci(move.uci);
    if (m == null) return;

    onDartchessMove(m);
  }

  void onDartchessMove(dc.Move move) {
    final oldPosition = state.position;
    final position = oldPosition.playUnchecked(move);

    emit(
      state.copyWith(
        moves: List.from(state.moves)..add(move.uci),
        currentFen: position.board.fen,
      ),
    );
  }
}
