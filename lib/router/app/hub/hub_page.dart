import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/text_style.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/firebase/firestore/game/live_game/live_games_cubit.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/router/app/hub/challenge/challenge_cards.dart';
import 'package:crea_chess/router/app/hub/challenge/challenge_tile.dart';
import 'package:crea_chess/router/app/hub/chessground/chessground_route.dart';
import 'package:crea_chess/router/app/hub/create_challenge/create_challenge_page.dart';
import 'package:crea_chess/router/app/hub/game/game_page.dart';
import 'package:crea_chess/router/shared/app_bar_actions.dart';
import 'package:crea_chess/router/shared/ccroute.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HubRoute extends CCRoute {
  const HubRoute._() : super(name: '/hub', icon: Icons.home);

  /// Instance
  static const i = HubRoute._();

  @override
  String getTitle(AppLocalizations l10n) => l10n.hub;

  @override
  Widget build(BuildContext context, GoRouterState state) => const HubPage();

  @override
  List<RouteBase> get routes => [
        ChessgroundTestingRoute.i.goRoute,
        CreateChallengeRoute.i.goRoute,
        GameRoute.i.goRoute,
      ];
}

class HubPage extends StatelessWidget {
  const HubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (kDebugMode)
            OutlinedButton(
              onPressed: () => context.pushRoute(ChessgroundTestingRoute.i),
              child: const Text('Test'), // TODO : remove
            ),
          CCGap.medium,
          ...getSideRoutesAppBarActions(context),
        ],
      ),
      backgroundColor: context.colorScheme.surfaceVariant,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ChallengeFiltersCubit()),
          BlocProvider(create: (context) => ChallengeFilterCubit()),
        ],
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                clipBehavior: Clip.none,
                child: CCPadding.allLarge(
                  child: const HubFeed(),
                ),
              ),
            ),
            const BigPlayButton(),
          ],
        ),
      ),
    );
  }
}

class HubFeed extends StatelessWidget {
  const HubFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BlocBuilder<LiveGamesCubit, Iterable<GameModel>>(
          builder: (context, liveGames) {
            final gamesInProgress = liveGames.where((e) => e.playable);
            return gamesInProgress.isEmpty
                ? CCGap.zero
                : Padding(
                    padding: const EdgeInsets.only(
                      bottom: CCSize.medium,
                    ),
                    child: GamesInProgressCard(
                      games: gamesInProgress,
                    ),
                  );
          },
        ),
        const ChallengeCards(),
      ],
    );
  }
}

class GamesInProgressCard extends StatelessWidget {
  const GamesInProgressCard({required this.games, super.key});

  final Iterable<GameModel> games;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: CCPadding.allMedium(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              // TODO : l10n
              'Parties en cours',
              style: context.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            CCGap.medium,
            ...games.map(GameChallengeTile.new),
          ],
        ),
      ),
    );
  }
}

class BigPlayButton extends StatelessWidget {
  const BigPlayButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.grey, //New
            blurRadius: 25,
            offset: Offset(0, -10),
          ),
        ],
        color: context.colorScheme.background,
      ),
      child: CCPadding.horizontalLarge(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CCGap.large,
            FilledButton.tonal(
              onPressed: () => context.pushRoute(CreateChallengeRoute.i),
              child: Text(context.l10n.play),
            ),
            CCGap.large,
          ],
        ),
      ),
    );
  }
}
