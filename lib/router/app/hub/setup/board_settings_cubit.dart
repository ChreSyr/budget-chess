import 'package:crea_chess/package/chessground/export.dart';
import 'package:crea_chess/package/unichess/src/board.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BoardSettingsCubit extends Cubit<BoardSettings> {
  BoardSettingsCubit() : super(const BoardSettings());

  void enableCoordinates(bool enable) =>
      emit(state.copyWith(enableCoordinates: enable));

  void setBoardColorScheme(BoardColorScheme Function(BoardSize) colorScheme) =>
      emit(state.copyWith(colorScheme: colorScheme));

  void setPieceAssets(PieceAssets assets) =>
      emit(state.copyWith(pieceAssets: assets));
}
