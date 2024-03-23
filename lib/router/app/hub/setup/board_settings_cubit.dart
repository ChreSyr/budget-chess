import 'package:crea_chess/package/chessground/export.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class BoardSettingsCubit extends HydratedCubit<BoardSettings> {
  BoardSettingsCubit() : super(const BoardSettings());

  @override
  BoardSettings? fromJson(Map<String, dynamic> json) =>
      BoardSettings.fromJson(json);

  @override
  Map<String, dynamic>? toJson(BoardSettings state) => state.toJson();

  void enableCoordinates(bool enable) =>
      emit(state.copyWith(enableCoordinates: enable));

  void setBoardTheme(BoardTheme boardTheme) =>
      emit(state.copyWith(boardTheme: boardTheme));

  void setPieceSet(PieceSet pieceSet) =>
      emit(state.copyWith(pieceSet: pieceSet));
}
