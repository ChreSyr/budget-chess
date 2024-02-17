import 'package:chessground/chessground.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/route/play/game/game_cubit.dart';
import 'package:crea_chess/route/play/setup/setup_body.dart';
import 'package:crea_chess/route/route_body.dart';
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
          blackHalfFen: '8/pppppppp/rnbqkbnr/8',
          status: GameStatus.setup,
        ),
      ),
      child: Builder(
        builder: (context) {
          final game = context.watch<GameCubit>().state;

          final authUid = context.watch<AuthenticationCubit>().state?.uid;
          if (game.blackId != authUid && game.whiteId != authUid) {
            return const WatchGameBody();
          }

          if (game.status == GameStatus.setup) {
            return SetupBody(
              side: game.whiteId == authUid ? Side.white : Side.black,
            );
          }

          return const LiveGameBody();
        },
      ),
    );
  }
}

class LiveGameBody extends StatelessWidget {
  const LiveGameBody({super.key});

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameCubit>().state;

    return Text('Game here : ${game.whiteHalfFen}');
  }
}

class WatchGameBody extends StatelessWidget {
  const WatchGameBody({super.key});

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameCubit>().state;

    return Text('WATCH Game here : ${game.whiteHalfFen}');
  }
}
