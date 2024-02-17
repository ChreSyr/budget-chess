import 'package:crea_chess/package/chessground/export.dart';
import 'package:crea_chess/package/chessground/setup_board.dart';
import 'package:crea_chess/package/dartchess/export.dart';
import 'package:crea_chess/package/firebase/firestore/game/setup/setup_model.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class SetupCubit extends HydratedCubit<SetupModel> {
  SetupCubit({required this.side, required String halfFen})
      : super(
          SetupModel(
            halfFen: halfFen,
          ),
        );

  final Side side;

  Board get board => Board.parseFen(
        '8/8/8/8/${state.halfFenAs(side)}',
      );

  void onDrop(CGDropMove move) {
    final to = parseSquare(move.squareId);
    if (to == null) return;
    final role = Role.fromChar(move.role.char);
    if (role == null) return;

    final newBoard = board.setPieceAt(
      to,
      Piece(
        color: side == Side.white ? Side.white : Side.black,
        role: role,
      ),
    );

    emit(state.copyWith(halfFen: newBoard.fen.substring(8)));
  }

  void onMove(CGMove move) {
    final from = parseSquare(move.from);
    final to = parseSquare(move.to);
    if (from == null || to == null) return;
    final piece = board.pieceAt(from);
    if (piece == null) return;
    var newBoard = board.removePieceAt(from);
    newBoard = newBoard.setPieceAt(to, piece);

    emit(state.copyWith(halfFen: newBoard.fen.substring(8)));
  }

  void onRemove(SquareId squareId) {
    final square = parseSquare(squareId);
    if (square == null) return;
    final newBoard = board.removePieceAt(square);

    emit(state.copyWith(halfFen: newBoard.fen.substring(8)));
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
