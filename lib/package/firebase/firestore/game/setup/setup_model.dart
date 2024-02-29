import 'package:crea_chess/package/dartchess/export.dart';
import 'package:crea_chess/package/firebase/firestore/game/board_size_converter.dart';
import 'package:crea_chess/route/play/setup/role.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'setup_model.freezed.dart';
part 'setup_model.g.dart';

@freezed
class SetupModel with _$SetupModel {
  const factory SetupModel({
    @protected required String fen,
    @BoardSizeConverter() required BoardSize boardSize,
  }) = _SetupModel;

  /// Required for the override getter
  const SetupModel._();

  factory SetupModel.fromJson(Map<String, dynamic> json) =>
      _$SetupModelFromJson(json);

  // ---

  /// Create an empty SetupModel with the given size
  factory SetupModel.fromBoardSize(BoardSize boardSize) =>
      SetupModel(fen: boardSize.emptyFen, boardSize: boardSize);

  String fenAs(Side color) =>
      color == Side.white ? fen.toUpperCase() : fen.toLowerCase();

  int get cost {
    var total = 0;

    final board = Board.parseFen(fen, size: boardSize);

    for (final role in Role.values) {
      final amount = board.byRole(role).length;
      total += amount * role.cost;
    }

    return total;
  }
}
