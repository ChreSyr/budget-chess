import 'package:chessground/chessground.dart';
import 'package:crea_chess/package/atomic_design/chess/setup_board.dart';
import 'package:crea_chess/route/play/setup/role.dart';
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

  void onDrop(DropMove move) {
    final to = dc_w.parseSquare(move.squareId);
    if (to == null) return;
    final role = dc_w.Role.fromChar(move.piece.role.char);
    if (role == null) return;

    board = board.setPieceAt(
      to,
      dc_w.Piece(
        color:
            move.piece.color == Side.white ? dc_w.Side.white : dc_w.Side.black,
        role: role,
      ),
    );

    emit(
      BoardData(
        interactableSide: state.interactableSide,
        orientation: state.orientation,
        sideToMove: state.sideToMove,
        fen: board.fen,
      ),
    );
  }

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

  void onRemove(SquareId squareId) {
    final square = dc_w.parseSquare(squareId);
    if (square == null) return;
    board = board.removePieceAt(square);
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
