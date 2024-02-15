import 'package:chessground/chessground.dart';
import 'package:crea_chess/route/play/setup/role.dart';
import 'package:dartchess_webok/dartchess_webok.dart' as dc_w;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'setup_model.freezed.dart';
part 'setup_model.g.dart';

@freezed
class SetupModel with _$SetupModel {
  const factory SetupModel({
    @protected required String halfFen,
    Side? betterWithSide,
  }) = _SetupModel;

  /// Required for the override getter
  const SetupModel._();

  factory SetupModel.fromJson(Map<String, dynamic> json) =>
      _$SetupModelFromJson(json);

  // ---

  String halfFenAs(Side color) =>
      color == Side.white ? halfFen.toUpperCase() : halfFen.toLowerCase();

  int get totalValue {
    var total = 0;

    final board = dc_w.Board.parseFen(
      '8/8/8/8/$halfFen',
    );

    for (final role in dc_w.Role.values) {
      final size = board.byRole(role).size;
      total += size * role.intValue;
    }

    return total;
  }
}
