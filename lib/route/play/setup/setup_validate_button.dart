import 'package:crea_chess/package/atomic_design/dialog/setup/budget_exceeded.dart';
import 'package:crea_chess/package/atomic_design/dialog/setup/incomplete_setup.dart';
import 'package:crea_chess/package/atomic_design/dialog/setup/inventory_exceeded.dart';
import 'package:crea_chess/package/atomic_design/dialog/setup/not_one_king.dart';
import 'package:crea_chess/route/play/setup/challenge_cubit.dart';
import 'package:crea_chess/route/play/setup/inventory_cubit.dart';
import 'package:crea_chess/route/play/setup/setup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetupValidateButton extends StatelessWidget {
  const SetupValidateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      icon: const Icon(Icons.check),
      label: const Text('Valider'), // TODO : l10n
      onPressed: () {
        final challenge = context.read<ChallengeCubit>().state;
        final setupCubit = context.read<SetupCubit>();
        final setup = setupCubit.state;
        final setupCost = setup.cost;

        if (challenge.budget < setupCost) {
          return showBudgetExceededDialog(
            pageContext: context,
            budget: challenge.budget,
            cost: setup.cost,
          );
        }

        final inventory = context.read<InventoryCubit>().state;

        if (!inventory.allows(setup)) {
          return showInventoryExceededDialog(
            pageContext: context,
          );
        }

        if (challenge.budget > setupCost) {
          return showIncompleteSetupDialog(
            pageContext: context,
          );
        }

        final board = setupCubit.board;
        final kingsCount = board.kings.size;
        if (kingsCount != 1) {
          return showNotOneKingDialog(
            pageContext: context,
          );
        }

        // TODO:  what if pawn on first rank ?
        // TODO : what if the black king is in check from the first move ?
      },
    );
  }
}
