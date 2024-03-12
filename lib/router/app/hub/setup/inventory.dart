import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/chessground/export.dart';
import 'package:crea_chess/package/unichess/unichess.dart';
import 'package:crea_chess/router/app/hub/game/game_cubit.dart';
import 'package:crea_chess/router/app/hub/setup/inventory_cubit.dart';
import 'package:crea_chess/router/app/hub/setup/role.dart';
import 'package:crea_chess/router/app/hub/setup/selected_role_cubit.dart';
import 'package:crea_chess/router/app/hub/setup/setup_cubit.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Inventory extends StatelessWidget {
  const Inventory({
    this.color = Side.white,
    this.settings = const BoardSettings(),
    this.interactable = true,
    super.key,
  });

  final Side color;
  final BoardSettings settings;
  final bool interactable;

  @override
  Widget build(BuildContext context) {
    final setup = context.watch<SetupCubit>().state;
    final inventory = context.read<InventoryCubit>().state;
    final leftInventory = inventory.less(setup: setup);

    final budget = context.read<GameCubit>().state?.game.challenge.budget;

    if (budget == null) return const SizedBox.shrink();

    final setupCost = setup.cost;

    // budgetLeft at zero makes the slots non-interactable
    final budgetLeft = interactable ? budget - setupCost : 0;

    final boardWidth = CCSize.boardSizeOf(context);
    final slotWidth = boardWidth / 6; // 6 slots per line

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
                  budgetLeft: budgetLeft,
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
    required this.budgetLeft,
    super.key,
  });

  final double width;
  final Side color;
  final IMap<PieceKind, AssetImage> assets; // TODO : cubit ?
  final Role role;
  final int amount;
  final bool isSelected;
  final int budgetLeft;

  @override
  Widget build(BuildContext context) {
    final disabled = amount <= 0 || budgetLeft < role.cost;

    if (isSelected && disabled) {
      context.read<SelectedRoleCubit>().selectRole(null);
    }

    final piece = PieceWidget(
      piece: CGPiece(
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
        onPanDown: disabled
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
            if (disabled)
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
                  backgroundColor: disabled
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
