import 'package:crea_chess/package/dartchess/export.dart';
import 'package:crea_chess/route/play/setup/role.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'setup_model.freezed.dart';
part 'setup_model.g.dart';

@freezed
class SetupModel with _$SetupModel {
  const factory SetupModel({
    @protected required String fen,
    @BoardSizeConverter() @Default(BoardSize.standard) BoardSize boardSize,
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

    final board = Board.parseFen(
      // TODO : dartchess BoardSize, then only give the fen here
      '${boardSize.emptyFen}/$fen',
    );

    for (final role in Role.values) {
      final size = board.byRole(role).size;
      total += size * role.cost;
    }

    return total;
  }
}
