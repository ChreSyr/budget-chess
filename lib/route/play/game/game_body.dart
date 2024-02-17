import 'package:chessground/chessground.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/route/play/game/game_cubit.dart';
import 'package:crea_chess/route/play/setup/board_settings_cubit.dart';
import 'package:crea_chess/route/play/setup/setup_body.dart';
import 'package:crea_chess/route/route_body.dart';
import 'package:dartchess_webok/dartchess_webok.dart' as dc;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GameBody extends RouteBody {
  const GameBody({super.key})
      : super(
          padded: false,
          centered: false,
          scrolled: false,
        );

  @override
  String getTitle(AppLocalizations l10n) {
    return 'Game'; // TODO : l10n
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameCubit(
        const GameModel(
          id: 'testing',
          challenge: ChallengeModel(
            id: '0',
            authorId: 'mael',
            budget: 19,
          ),
          whiteId: 'WVJCtjHxhaU4c5beOaN87Rt9E4F2',
          blackId: '2Kp6LTX4TqSVPphhCtloPZ9oPo43',
          blackHalfFen: '8/8/pppppppp/rnbqkbnr',
          status: GameStatus.setup,
        ),
      ),
      child: const _GameBody(),
    );
  }
}

class _GameBody extends StatelessWidget {
  const _GameBody();

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameCubit>().state;
    final authUid = context.watch<AuthenticationCubit>().state?.uid;

    final plays = game.blackId == authUid || game.whiteId == authUid;
    final isWhite = game.whiteId == authUid;

    if (plays && game.status == GameStatus.setup) {
      return SetupBody(
        side: isWhite ? Side.white : Side.black,
      );
    }

    final boardSettings = context.watch<BoardSettingsCubit>().state;
    final interactableSide = plays
        ? isWhite
            ? InteractableSide.white
            : InteractableSide.black
        : InteractableSide.none;
    final position = game.position;

    // TODO : OrientationCubit ?
    final orientation = plays
        ? isWhite
            ? Side.white
            : Side.black
        : Side.white;

    return Center(
      child: Board(
        size: MediaQuery.of(context).size.width,
        settings: boardSettings,
        data: BoardData(
          interactableSide: interactableSide,
          validMoves: null,
          orientation: orientation,
          fen: position.fen,
          lastMove: null,
          sideToMove: position.turn == dc.Side.white ? Side.white : Side.black,
          isCheck: position.isCheck,
          premove: null,
        ),
        onMove: (move, {isDrop, isPremove}) {},
        onPremove: (move) {},
      ),
    );
  }
}
