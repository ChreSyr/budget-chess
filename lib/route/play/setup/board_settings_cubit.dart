import 'package:chessground/chessground.dart';
import 'package:crea_chess/frenzy_piece_set.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BoardSettingsCubit extends Cubit<BoardSettings> {
  BoardSettingsCubit()
      : super(
          const BoardSettings(
            colorScheme: BoardColorScheme.blue3,
            pieceAssets: frenzyPieceSet,
          ),
        );
}
