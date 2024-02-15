import 'package:chessground/chessground.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'inventory_model.freezed.dart';
part 'inventory_model.g.dart';

@freezed
class InventoryModel with _$InventoryModel {
  const factory InventoryModel({
    required String id,
    required String ownerId,
    @Default(2) int bishops,
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
        Role.king: 1,
        Role.queen: queens,
        Role.rook: rooks,
        Role.bishop: bishops,
        Role.knight: knights,
        Role.pawn: pawns,
      };
}
