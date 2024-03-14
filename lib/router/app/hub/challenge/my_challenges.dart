import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/firebase/firestore/game/live_game/live_games_cubit.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/router/app/hub/challenge/challenge_tile.dart';
import 'package:crea_chess/router/app/hub/create_challenge/create_challenge_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MyChallenges extends StatelessWidget {
  const MyChallenges({required this.myChallenges, super.key});

  final Iterable<ChallengeModel> myChallenges;

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
            CCGap.small,
            BlocBuilder<LiveGamesCubit, Iterable<GameModel>>(
              builder: (context, liveGames) {
                final gamesInProgress = liveGames.where((e) => e.playable);
                return gamesInProgress.isEmpty
                    ? const SizedBox.shrink()
                    : Column(
                        children: [
                          CCGap.small,
                          // TODO : l10n
                          Text(
                            // ignore: lines_longer_than_80_chars
                            'You have ${gamesInProgress.length} games in progress.',
                          ),
                          CCGap.small,
                          ...gamesInProgress.map(GameChallengeTile.new),
                        ],
                      );
              },
            ),
            if (myChallenges.isNotEmpty) ...[
              CCGap.small,
              Text(
                context.l10n.waitingOpponent,
                textAlign: TextAlign.center,
              ),
              CCGap.small,
              ...myChallenges.map(ChallengeTile.new),
            ],
            if (myChallenges.length > 1) ...[
              CCGap.medium,
              Row(
                children: [
                  const Icon(Icons.info_outline),
                  CCGap.small,
                  // TODO : tips
                  Expanded(child: Text(context.l10n.tipChallengesRemoved)),
                ],
              ),
            ],
            CCGap.medium,
            FilledButton.icon(
              onPressed: () => context.pushNamed(CreateChallengeRoute.i.name),
              icon: const Icon(Icons.add),
              label: Text(context.l10n.challengeCreate),
            ),
            CCGap.large,
          ],
        ),
      ),
    );
  }
}
