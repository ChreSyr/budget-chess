import 'package:crea_chess/package/chessground/export.dart';
import 'package:crea_chess/package/unichess/unichess.dart';
import 'package:crea_chess/package/firebase/firestore/game/setup/setup_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'inventory_model.freezed.dart';
part 'inventory_model.g.dart';

@freezed
class InventoryModel with _$InventoryModel {
  const factory InventoryModel({
    required String id,
    required String ownerId,
    @Default(2) int bishops,
    @Default(1) int kings,
    @Default(2) int knights,
    @Default(8) int pawns,
    @Default(1) int queens,
    @Default(2) int rooks,
  }) = _InventoryModel;

  /// Required for the override getter
  const InventoryModel._();

  factory InventoryModel.fromJson(Map<String, dynamic> json) =>
      _$InventoryModelFromJson(json);

  // ---

  bool get isLegal =>
      bishops >= 0 &&
      kings >= 0 &&
      knights >= 0 &&
      pawns >= 0 &&
      queens >= 0 &&
      rooks >= 0;

  Map<Role, int> get pieces => {
        Role.king: kings,
        Role.queen: queens,
        Role.rook: rooks,
        Role.bishop: bishops,
        Role.knight: knights,
        Role.pawn: pawns,
      };

  /// Return an inventory where the pieces of the setup are removed from this
  /// inventory.
  ///
  /// Usefull when calculating the pieces that can still be added to the setup.
  InventoryModel less({required SetupModel setup}) {
    final pieces = readFen(
      fen: setup.fenAs(Side.white),
      boardSize: setup.boardSize,
    ).values;
    final roles = <Role, int>{};
    for (final piece in pieces) {
      roles[piece.role] = (roles[piece.role] ?? 0) + 1;
    }

    return InventoryModel(
      id: id,
      ownerId: ownerId,
      bishops: bishops - (roles[Role.bishop] ?? 0),
      kings: kings - (roles[Role.king] ?? 0),
      knights: knights - (roles[Role.knight] ?? 0),
      pawns: pawns - (roles[Role.pawn] ?? 0),
      queens: queens - (roles[Role.queen] ?? 0),
      rooks: rooks - (roles[Role.rook] ?? 0),
    );
  }

  bool allows(SetupModel setup) {
    return less(setup: setup).isLegal;
  }
}
