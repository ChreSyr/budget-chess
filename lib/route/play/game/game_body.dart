import 'package:crea_chess/package/chessground/export.dart';
import 'package:crea_chess/package/dartchess/export.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/route/play/game/game_cubit.dart';
import 'package:crea_chess/route/play/game/game_state.dart';
import 'package:crea_chess/route/play/game/player_tile.dart';
import 'package:crea_chess/route/play/game/side.dart';
import 'package:crea_chess/route/play/setup/board_settings_cubit.dart';
import 'package:crea_chess/route/play/setup/setup_body.dart';
import 'package:crea_chess/route/route_body.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GameBody extends RouteBody {
  const GameBody({required this.gameId, super.key})
      : super(
          padded: false,
          centered: false,
          scrolled: false,
        );

  // TODO : remove ? rework ?
  factory GameBody.games() => const GameBody(gameId: 'none');

  final String gameId;

  @override
  String getTitle(AppLocalizations l10n) {
    return 'Game'; // TODO : l10n
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GameModel?>(
      stream: liveGameCRUD.stream(documentId: gameId),
      builder: (context, snapshot) {
        final game = snapshot.data;

        // TODO : rework
        if (game == null) return const SizedBox.shrink();

        print('Steps length : ${game.steps.length}');

        return BlocProvider(
          create: (context) => GameCubit(
            GameState(
              game: game,
              stepCursor: 0,
            ),
          ),
          child: const _GameBody(),
        );
      },
    );
  }
}

class _GameBody extends StatelessWidget {
  const _GameBody();

  @override
  Widget build(BuildContext context) {
    final gameCubit = context.watch<GameCubit>();
    final gameState = gameCubit.state;
    final game = gameState.game;

    final authUid = context.watch<AuthenticationCubit>().state?.uid;

    final side = game.blackId == authUid
        ? Side.black
        : game.whiteId == authUid
            ? Side.white
            : null;

    if (side != null && game.status == GameStatus.created) {
      return SetupBody(side: side);
    }

    final boardSettings = context.watch<BoardSettingsCubit>().state;
    final interactableSide = side?.interactable ?? InteractableSide.none;

    // null means the setup is not finished
    final position = gameState.position;

    final orientation = side ?? Side.white;

    final lastMove = game.steps.lastOrNull?.sanMove?.move;

    return Center(
      child: Column(
        children: [
          PlayerTile(
            userId: orientation == Side.white ? game.blackId : game.whiteId,
            winner: game.winner,
          ),
          BoardWidget(
            size: MediaQuery.of(context).size.width,
            settings: boardSettings,
            data: BoardData(
              interactableSide:
                  game.playable ? interactableSide : InteractableSide.none,
              validMoves: game.playable &&
                      position != null &&
                      side?.toDartchess == position.turn
                  ? algebraicLegalMoves(position)
                  : IMap(const {}),
              orientation: orientation,
              fen: position?.fen ?? '',
              lastMove: lastMove == null ? null : CGMove.fromUci(lastMove.uci),
              sideToMove: position?.turn.toChessground,
              isCheck: position?.isCheck,
              premove: gameState.premove,
            ),
            onMove: gameCubit.onCGMove,
            onPremove: gameCubit.onPremove,
          ),
          PlayerTile(
            userId: orientation == Side.white ? game.whiteId : game.blackId,
            winner: game.winner,
          ),
        ],
      ),
    );
  }
}
