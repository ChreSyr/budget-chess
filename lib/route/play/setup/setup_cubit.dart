import 'package:chessground/chessground.dart';
import 'package:dartchess_webok/dartchess_webok.dart' as dc_w;
import 'package:flutter_bloc/flutter_bloc.dart';

class SetupCubit extends Cubit<BoardData> {
  SetupCubit({required this.side, required String fen})
      : board = dc_w.Board.parseFen(fen),
        super(
          BoardData(
            interactableSide: side == Side.white
                ? InteractableSide.white
                : InteractableSide.black,
            orientation: side,
            sideToMove: side,
            fen: fen,
          ),
        );

  final Side side;
  dc_w.Board board;

  void onMove(Move move) {
    final from = dc_w.parseSquare(move.from);
    final to = dc_w.parseSquare(move.to);
    if (from == null || to == null) return;
    final piece = board.pieceAt(from);
    if (piece == null) return;
    board = board.removePieceAt(from);
    board = board.setPieceAt(to, piece);
    emit(
      BoardData(
        interactableSide: state.interactableSide,
        orientation: state.orientation,
        sideToMove: state.sideToMove,
        fen: board.fen,
      ),
    );
  }
}
