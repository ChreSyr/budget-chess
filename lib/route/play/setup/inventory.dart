import 'package:chessground/chessground.dart';
import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/firebase/firestore/game/inventory/inventory_model.dart';
import 'package:crea_chess/route/play/setup/selected_role_cubit.dart';
import 'package:crea_chess/route/play/setup/setup_cubit.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    final setupCubit = context.watch<SetupCubit>();
    final board = setupCubit.board;

    final leftInventory = inventory.less(color: color, board: board);

    return BlocBuilder<SelectedRoleCubit, Role?>(
      builder: (context, selectedRole) {
        return Wrap(
          children: leftInventory.pieces.entries
              .map<InventorySlot>(
                (entry) => InventorySlot(
                  width: slotWidth,
                  color: color,
                  assets: settings.pieceAssets,
                  role: entry.key,
                  amount: entry.value,
                  isSelected: entry.key == selectedRole,
                ),
              )
              .toList(),
        );
      },
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
    required this.isSelected,
    super.key,
  });

  final double width;
  final Side color;
  final IMap<PieceKind, AssetImage> assets; // TODO : cubit ?
  final Role role;
  final int amount;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    if (isSelected && amount <= 0) {
      context.read<SelectedRoleCubit>().selectRole(null);
    }

    final piece = PieceWidget(
      piece: Piece(
        color: color,
        role: role,
      ),
      size: width,
      pieceAssets: assets,
    );

    return SizedBox(
      height: width,
      width: width,
      child: GestureDetector(
        onPanDown: amount <= 0
            ? null
            : (_) => context.read<SelectedRoleCubit>().selectRole(role),
        child: Stack(
          children: [
            Card(
              color: isSelected
                  ? CCColor.primary(context)
                  : CCColor.secondaryContainer(context),
              child: Draggable<Role>(
                data: role,
                feedback: piece,
                childWhenDragging: SizedBox(
                  height: width,
                  width: width,
                ),
                child: piece,
              ),
            ),
            if (amount <= 0)
              Card(
                color: CCColor.transparentGrey,
                child: SizedBox(
                  height: width,
                  width: width,
                ),
              ),
            Align(
              alignment: Alignment.topRight,
              child: CCPadding.allXxsmall(
                child: Badge.count(
                  count: amount,
                  backgroundColor: amount <= 0
                      ? CCColor.outline(context)
                      : CCColor.primary(context),
                  textColor: CCColor.background(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
