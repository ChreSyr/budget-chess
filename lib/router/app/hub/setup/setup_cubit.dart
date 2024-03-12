import 'package:crea_chess/package/chessground/export.dart';
import 'package:crea_chess/package/chessground/widgets/setup_board.dart';
import 'package:crea_chess/package/firebase/firestore/game/setup/setup_model.dart';
import 'package:crea_chess/package/unichess/unichess.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class SetupCubit extends HydratedCubit<SetupModel> {
  SetupCubit({required this.side, required SetupModel setup}) : super(setup) {
    // required because of the hydratation of the cubit
    if (state.boardSize != setup.boardSize) emit(setup);
  }

  final Side side;

  // TODO : from getter to final
  Board get board => Board.parseFen(state.fenAs(side), size: state.boardSize);

  // TODO : remove
  void resetFen() => emit(state.copyWith(fen: state.boardSize.emptyFen));

  void onDrop(CGDropMove move) {
    final to = state.boardSize.parseSquare(move.squareId);
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

    emit(state.copyWith(fen: newBoard.fen));
  }

  void onMove(CGMove move) {
    final from = state.boardSize.parseSquare(move.from);
    final to = state.boardSize.parseSquare(move.to);
    if (from == null || to == null) return;
    final piece = board.pieceAt(from);
    if (piece == null) return;
    var newBoard = board.removePieceAt(from);
    newBoard = newBoard.setPieceAt(to, piece);

    emit(state.copyWith(fen: newBoard.fen));
  }

  void onRemove(SquareId squareId) {
    final square = state.boardSize.parseSquare(squareId);
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
