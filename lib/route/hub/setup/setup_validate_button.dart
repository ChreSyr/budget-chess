import 'package:crea_chess/package/atomic_design/dialog/setup/budget_exceeded.dart';
import 'package:crea_chess/package/atomic_design/dialog/setup/incomplete_setup.dart';
import 'package:crea_chess/package/atomic_design/dialog/setup/inventory_exceeded.dart';
import 'package:crea_chess/package/atomic_design/dialog/setup/not_one_king.dart';
import 'package:crea_chess/package/unichess/unichess.dart';
import 'package:crea_chess/route/hub/game/game_cubit.dart';
import 'package:crea_chess/route/hub/setup/inventory_cubit.dart';
import 'package:crea_chess/route/hub/setup/setup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetupValidateButton extends StatelessWidget {
  const SetupValidateButton({required this.validated, super.key});

  final bool validated;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      icon: const Icon(Icons.check),
      label: Text(validated ? 'Validé' : 'Valider'), // TODO : l10n
      onPressed: validated
          ? null
          : () {
              final challenge = context.read<GameCubit>().state?.game.challenge;
              if (challenge == null) return;
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

              final board = setupCubit.board;
              final kingsCount = board.kings.length;
              if (kingsCount != 1) {
                return showNotOneKingDialog(
                  pageContext: context,
                );
              }

              void submit() => context
                  .read<GameCubit>()
                  .submitSetup(setup, forSide: setupCubit.side);

              if (challenge.budget > setupCost) {
                return showIncompleteSetupDialog(
                  pageContext: context,
                  onYes: submit,
                );
              }

              submit();

              // TODO:  what if pawn on first rank ?
              // TODO : what if the black king is in check from the first move ?
            },
    );
  }
}
