import 'package:chessground/chessground.dart';
import 'package:crea_chess/package/atomic_design/chess/setup_board.dart';
import 'package:crea_chess/package/firebase/firestore/game/setup/setup_model.dart';
import 'package:crea_chess/route/play/setup/role.dart';
import 'package:dartchess_webok/dartchess_webok.dart' as dc_w;
import 'package:hydrated_bloc/hydrated_bloc.dart';

class SetupCubit extends HydratedCubit<SetupModel> {
  SetupCubit({required this.side, required String fen})
      : super(SetupModel(fen: fen));

  final Side side;

  dc_w.Board get board => dc_w.Board.parseFen(state.fen);

  void onDrop(DropMove move) {
    final to = dc_w.parseSquare(move.squareId);
    if (to == null) return;
    final role = dc_w.Role.fromChar(move.piece.role.char);
    if (role == null) return;

    final newBoard = board.setPieceAt(
      to,
      dc_w.Piece(
        color:
            move.piece.color == Side.white ? dc_w.Side.white : dc_w.Side.black,
        role: role,
      ),
    );

    emit(state.copyWith(fen: newBoard.fen));
  }

  void onMove(Move move) {
    final from = dc_w.parseSquare(move.from);
    final to = dc_w.parseSquare(move.to);
    if (from == null || to == null) return;
    final piece = board.pieceAt(from);
    if (piece == null) return;
    var newBoard = board.removePieceAt(from);
    newBoard = newBoard.setPieceAt(to, piece);

    emit(state.copyWith(fen: newBoard.fen));
  }

  void onRemove(SquareId squareId) {
    final square = dc_w.parseSquare(squareId);
    if (square == null) return;
    final newBoard = board.removePieceAt(square);

    emit(state.copyWith(fen: newBoard.fen));
  }

  @override
  SetupModel? fromJson(Map<String, dynamic> json) {
    return SetupModel.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(SetupModel state) {
    return state.toJson();
  }
}
