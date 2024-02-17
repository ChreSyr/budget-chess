import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/chessground/setup_board.dart';
import 'package:crea_chess/package/dartchess/export.dart';
import 'package:crea_chess/route/play/game/game_cubit.dart';
import 'package:crea_chess/route/play/setup/board_settings_cubit.dart';
import 'package:crea_chess/route/play/setup/inventory.dart';
import 'package:crea_chess/route/play/setup/inventory_cubit.dart';
import 'package:crea_chess/route/play/setup/selected_role_cubit.dart';
import 'package:crea_chess/route/play/setup/setup_budget_counter.dart';
import 'package:crea_chess/route/play/setup/setup_cubit.dart';
import 'package:crea_chess/route/play/setup/setup_validate_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetupBody extends StatelessWidget {
  const SetupBody({required this.side, super.key});

  final Side side;

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
            halfFen: '8/8/8/8',
          ),
        ),
        BlocProvider(
          create: (context) => SelectedRoleCubit(),
        ),
      ],
      child: const _SetupBody(),
    );
  }
}

class _SetupBody extends StatelessWidget {
  const _SetupBody();

  @override
  Widget build(BuildContext context) {
    final challenge = context.read<GameCubit>().state.challenge;

    final setupCubit = context.watch<SetupCubit>();
    final side = setupCubit.side;
    final setup = setupCubit.state;

    final settings = context.watch<BoardSettingsCubit>().state;

    return Column(
      children: [
        BlocBuilder<SelectedRoleCubit, Role?>(
          builder: (context, selectedRole) {
            return SetupBoard(
              size: CCSize.boardSizeOf(context),
              halfFen: setup.halfFenAs(side),
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
            );
          },
        ),
        CCGap.small,
        Inventory(
          color: side,
          settings: settings,
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
              const SetupValidateButton(),
            ],
          ),
        ),
      ],
    );
  }
}
