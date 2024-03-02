import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/chessground/widgets/setup_board.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/unichess/unichess.dart';
import 'package:crea_chess/route/hub/game/game_cubit.dart';
import 'package:crea_chess/route/hub/setup/board_settings_cubit.dart';
import 'package:crea_chess/route/hub/setup/inventory.dart';
import 'package:crea_chess/route/hub/setup/inventory_cubit.dart';
import 'package:crea_chess/route/hub/setup/selected_role_cubit.dart';
import 'package:crea_chess/route/hub/setup/setup_budget_counter.dart';
import 'package:crea_chess/route/hub/setup/setup_cubit.dart';
import 'package:crea_chess/route/hub/setup/setup_opponent_tile.dart';
import 'package:crea_chess/route/hub/setup/setup_validate_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetupBody extends StatelessWidget {
  const SetupBody({required this.side, required this.challenge, super.key});

  final Side side;
  final ChallengeModel challenge;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => InventoryCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => SetupCubit(
            side: side,
            setup: SetupModel.fromBoardSize(challenge.setupSize),
          ),
        ),
        BlocProvider(
          create: (context) => SelectedRoleCubit(),
        ),
      ],
      child: Column(
        children: [
          if (kDebugMode)
            Builder(
              builder: (context) {
                return OutlinedButton(
                  onPressed: context.read<SetupCubit>().resetFen,
                  child: const Text('Reset'),
                );
              },
            ),
          const _SetupBody(),
        ],
      ),
    );
  }
}

class _SetupBody extends StatelessWidget {
  const _SetupBody();

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameCubit>().state?.game;

    // TODO : loading
    if (game == null) return const SizedBox.shrink();

    final challenge = game.challenge;

    final setupCubit = context.watch<SetupCubit>();
    final side = setupCubit.side;
    final setup = setupCubit.state;

    assert(setup.boardSize == challenge.setupSize);

    final validatedSetup = game.sideHasSetup(side);

    final settings = context.watch<BoardSettingsCubit>().state;

    return SizedBox(
      width: CCSize.boardSizeOf(context),
      child: Column(
        children: [
          BlocBuilder<SelectedRoleCubit, Role?>(
            builder: (context, selectedRole) {
              return SetupBoard(
                setup: setup,
                color: side,
                onAdd: selectedRole == null
                    ? null
                    : (squareId) => setupCubit.onDrop(
                          CGDropMove(
                            role: selectedRole,
                            squareId: squareId,
                          ),
                        ),
                onDrop: setupCubit.onDrop,
                onMove: setupCubit.onMove,
                onRemove: setupCubit.onRemove,
                settings: settings,
                interactable: !validatedSetup,
              );
            },
          ),
          CCGap.small,
          Inventory(
            color: side,
            settings: settings,
            interactable: !validatedSetup,
          ),
          CCGap.small,
          const Divider(height: 0),
          CCPadding.allSmall(
            child: Row(
              children: [
                SetupBudgetCounter(
                  budget: challenge.budget,
                  cost: setup.cost,
                ),
                const Expanded(child: SizedBox.shrink()),
                SetupValidateButton(validated: validatedSetup),
              ],
            ),
          ),
          CCGap.medium,
          SetupOpponentTile(game: game),
        ],
      ),
    );
  }
}
