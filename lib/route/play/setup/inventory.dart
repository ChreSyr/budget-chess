import 'package:chessground/chessground.dart';
import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/firebase/firestore/game/inventory/inventory_model.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

class Inventory extends StatelessWidget {
  const Inventory({
    required this.inventory,
    required this.color,
    this.settings = const BoardSettings(),
    super.key,
  });

  final InventoryModel inventory;
  final Side color;
  final BoardSettings settings;

  @override
  Widget build(BuildContext context) {
    final boardWidth = CCSize.boardSizeOf(context);
    final slotWidth = boardWidth / 6; // 6 slots per line

    return Wrap(
      children: inventory.pieces.entries
          .map<InventorySlot>(
            (entry) => InventorySlot(
              width: slotWidth,
              color: color,
              assets: settings.pieceAssets,
              role: entry.key,
              amount: entry.value,
            ),
          )
          .toList(),
    );
  }
}

class InventorySlot extends StatelessWidget {
  const InventorySlot({
    required this.width,
    required this.color,
    required this.assets,
    required this.role,
    required this.amount,
    super.key,
  });

  final double width;
  final Side color;
  final IMap<PieceKind, AssetImage> assets; // TODO : cubit ?
  final Role role;
  final int amount;

  @override
  Widget build(BuildContext context) {
    final piece = PieceWidget(
      piece: Piece(
        color: color,
        role: role,
      ),
      size: width,
      pieceAssets: assets,
    );

    return SizedBox(
      width: width,
      child: Stack(
        children: [
          Card(
            color: amount == 0 ? CCColor.transparentGrey : null,
            child: piece,
          ),
          Align(
            alignment: Alignment.topRight,
            child: CCPadding.allXxsmall(
              child: Badge.count(
                count: amount,
                backgroundColor: CCColor.primary(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
