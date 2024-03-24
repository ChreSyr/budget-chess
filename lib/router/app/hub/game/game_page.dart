import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/chessground/export.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/package/unichess/unichess.dart';
import 'package:crea_chess/router/app/app_router.dart';
import 'package:crea_chess/router/app/chats/chat/chat_page.dart';
import 'package:crea_chess/router/app/chats/chat/widget/input/input.dart';
import 'package:crea_chess/router/app/hub/game/game_cubit.dart';
import 'package:crea_chess/router/app/hub/game/player_tile.dart';
import 'package:crea_chess/router/app/hub/game/side.dart';
import 'package:crea_chess/router/app/hub/setup/board_settings_cubit.dart';
import 'package:crea_chess/router/app/hub/setup/setup_screen.dart';
import 'package:crea_chess/router/shared/app_bar_actions.dart';
import 'package:crea_chess/router/shared/ccroute.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GameRoute extends CCRoute {
  GameRoute._() : super(name: ':gameId');

  /// Instance
  static final i = GameRoute._();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      GamePage(gameId: state.pathParameters['gameId'] ?? 'none');

  static void push({required String gameId}) =>
      appRouter.pushNamed(i.name, pathParameters: {'gameId': gameId});
}

class GamePage extends StatelessWidget {
  const GamePage({required this.gameId, super.key});

  // TODO : remove ? rework ?
  factory GamePage.games() => const GamePage(gameId: 'none');

  final String gameId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameCubit(gameId: gameId),
      child: Scaffold(
        appBar: AppBar(
          title: Text(GameRoute.i.getTitle(context.l10n)),
          actions: getSideRoutesAppBarActions(context),
        ),
        body: const _GamePage(),
      ),
    );
  }
}

class _GamePage extends StatelessWidget {
  const _GamePage();

  @override
  Widget build(BuildContext context) {
    final gameCubit = context.watch<GameCubit>();
    final gameState = gameCubit.state;

    // TODO : loading
    if (gameState == null) return const SizedBox.shrink();

    final game = gameState.game;

    if (game.status == GameStatus.aborted) {
      return Align(
        alignment: Alignment.topCenter,
        child: CCPadding.allLarge(
          child: const Text('Cette partie a été annulée'),
        ),
      );
    }

    final authUid = context.watch<UserCubit>().state.id;

    final side = game.blackId == authUid
        ? Side.black
        : game.whiteId == authUid
            ? Side.white
            : null;

    if (side != null && game.status == GameStatus.created) {
      return SetupScreen(side: side, challenge: game.challenge);
    }

    final boardSettings = context.watch<BoardSettingsCubit>().state;
    final interactableSide = side?.interactable ?? InteractableSide.none;

    // null means the setup is not finished
    final position = gameState.position;
    if (position == null) return const SizedBox.shrink();

    final orientation = side ?? Side.white;

    final lastMove = game.steps.lastOrNull?.sanMove?.move;

    return Stack(
      children: [
        ListView(
          children: [
            PlayerTile(
              userId: orientation == Side.white ? game.blackId : game.whiteId,
              winner: game.winner,
            ),
            BoardWidget(
              size: game.challenge.boardSize,
              settings: boardSettings,
              data: BoardData(
                interactableSide:
                    game.playable ? interactableSide : InteractableSide.none,
                validMoves: game.playable && side?.toDartchess == position.turn
                    ? position.algebraicLegalMoves()
                    : IMap(const {}),
                orientation: orientation,
                fen: position.fen,
                lastMove: lastMove == null
                    ? null
                    : CGMove.fromUci(lastMove.uci(position.board.size)),
                sideToMove: position.turn.toChessground,
                isCheck: position.isCheck,
                premove: gameState.premove,
              ),
              onMove: gameCubit.onCGMove,
              onPremove: gameCubit.onPremove,
            ),
            PlayerTile(
              userId: orientation == Side.white ? game.whiteId : game.blackId,
              winner: game.winner,
            ),
            CCGap.xxxlarge,
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            focusColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: IgnorePointer(
              child: Input(
                onSendPressed: (_) {},
              ),
            ),
            onTap: () => showModalBottomSheet<String>(
              context: context,
              backgroundColor: const Color.fromARGB(64, 0, 0, 0),
              isScrollControlled: true,
              builder: (context) {
                return Stack(
                  children: [
                    ChatScreen(
                      authUid: authUid,
                      otherId: game.otherPlayer(authUid) ?? '',
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: CCWidgetSize.xxsmall),
                        child: IconButton.filledTonal(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            context.pop();
                            FocusScope.of(context).unfocus();
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
