import 'package:crea_chess/package/atomic_design/dialog/yes_no.dart';
import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/chessground/widgets/setup_board.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/lichess/lichess_icons.dart';
import 'package:crea_chess/package/unichess/unichess.dart';
import 'package:crea_chess/router/app/hub/game/game_cubit.dart';
import 'package:crea_chess/router/app/hub/setup/board_settings_cubit.dart';
import 'package:crea_chess/router/app/hub/setup/inventory.dart';
import 'package:crea_chess/router/app/hub/setup/inventory_cubit.dart';
import 'package:crea_chess/router/app/hub/setup/selected_role_cubit.dart';
import 'package:crea_chess/router/app/hub/setup/setup_budget_counter.dart';
import 'package:crea_chess/router/app/hub/setup/setup_cubit.dart';
import 'package:crea_chess/router/app/hub/setup/setup_opponent_tile.dart';
import 'package:crea_chess/router/app/hub/setup/setup_validate_button.dart';
import 'package:crea_chess/router/shared/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetupScreen extends StatelessWidget {
  const SetupScreen({required this.side, required this.challenge, super.key});

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
      child: const _SetupPage(),
    );
  }
}

class _SetupPage extends StatelessWidget {
  const _SetupPage();

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
      child: ListView(
        children: [
          SetupOpponentTile(game: game),
          Row(
            children: [
              IconButton(
                onPressed: setupCubit.resetFen,
                icon: const Icon(Icons.cancel), // TODO : l10n
              ),
              const Expanded(child: CCGap.zero),
              IconButton(
                icon: const Icon(LichessIcons.flag),
                onPressed: () => showYesNoDialog(
                  pageContext: context,
                  title: 'Voulez-vous annuler la partie en cours ?',
                  onYes: () => liveGameCRUD.abort(game: game),
                ),
              ),
              IconButton(
                onPressed: () => BoardSettingsCard.showAsModal(context),
                icon: const Icon(Icons.settings), // TODO : l10n
              ),
            ],
          ),
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
          CCGap.xxxlarge,
        ],
      ),
    );
  }
}
