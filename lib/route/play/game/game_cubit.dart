import 'package:chessground/chessground.dart';
import 'package:crea_chess/package/firebase/export.dart';
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
}
