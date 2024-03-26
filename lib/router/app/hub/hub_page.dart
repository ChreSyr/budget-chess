import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/widget/feed_card.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/firebase/firestore/game/live_game/live_games_cubit.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/router/app/chats/chat_home_page.dart';
import 'package:crea_chess/router/app/hub/challenge/challenge_cards.dart';
import 'package:crea_chess/router/app/hub/challenge/challenge_tile.dart';
import 'package:crea_chess/router/app/hub/chessground/chessground_route.dart';
import 'package:crea_chess/router/app/hub/create_challenge/create_challenge_page.dart';
import 'package:crea_chess/router/app/hub/game/game_page.dart';
import 'package:crea_chess/router/app/user/user_page.dart';
import 'package:crea_chess/router/app/user/widget/user_photo.dart';
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
                      games: gamesInProgress.toList(),
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

  final List<GameModel> games;

  @override
  Widget build(BuildContext context) {
    return FeedCard(
      title: 'Parties en cours', // TODO : l10n
      child: ListView.separated(
        itemBuilder: (context, index) => GameChallengeTile(games[index]),
        separatorBuilder: (context, index) => Divider(
          color: context.colorScheme.onBackground,
          height: 0,
        ),
        itemCount: games.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
      ),
    );
  }
}

class GameChallengeTile extends StatelessWidget {
  const GameChallengeTile(this.game, {super.key});

  final GameModel game;

  @override
  Widget build(BuildContext context) {
    final authUid = context.read<UserCubit>().state.id;
    final opponentId = game.otherPlayer(authUid);
    if (opponentId == null) return CCGap.zero; // corrupted challenge

    void enterGame() => GameRoute.push(gameId: game.challenge.id);

    final opponentSentNewMessages = context.select<NewMessagesCubit, bool>(
      (cubit) => cubit.state.any((message) => message.authorId == opponentId),
    );

    return InkWell(
      onTap: enterGame,
      child: SizedBox(
        height: CCWidgetSize.xxxsmall,
        child: Row(
          children: [
            CCGap.small,
            UserPhoto.fromId(
              userId: opponentId,
              radius: CCSize.medium,
              onTap: () => UserRoute.pushId(userId: opponentId),
              showConnectedIndicator: true,
            ),
            CCGap.medium,
            const Icon(Icons.attach_money),
            CCGap.small,
            Text(game.challenge.budget.toString()),
            const Expanded(child: CCGap.small),
            if (opponentSentNewMessages) ...[
              CCGap.small,
              const Icon(Icons.forum),
            ],
            CCGap.small,
            SmallActionButton(
              onPressed: enterGame,
              child: const Text('rejoindre'), // TODO : l10n
            ),
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
