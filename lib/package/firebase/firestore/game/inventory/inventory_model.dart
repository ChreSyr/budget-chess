import 'package:chessground/chessground.dart';
import 'package:dartchess_webok/dartchess_webok.dart' as dc_w;
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

  Map<Role, int> get pieces => {
        Role.king: kings,
        Role.queen: queens,
        Role.rook: rooks,
        Role.bishop: bishops,
        Role.knight: knights,
        Role.pawn: pawns,
      };

  /// Return an inventory where the pieces of the color required who are on the
  /// board are removed from the inventory
  InventoryModel less({required Side color, required dc_w.Board board}) {
    final pieces = color == Side.white ? board.white : board.black;
    return InventoryModel(
      id: id,
      ownerId: ownerId,
      bishops: bishops - pieces.intersect(board.bishops).size,
      kings: kings - pieces.intersect(board.kings).size,
      knights: knights - pieces.intersect(board.knights).size,
      pawns: pawns - pieces.intersect(board.pawns).size,
      queens: queens - pieces.intersect(board.queens).size,
      rooks: rooks - pieces.intersect(board.rooks).size,
    );
  }
}
