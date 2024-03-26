import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/widget/feed_card.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/router/app/chats/chat_home_page.dart';
import 'package:crea_chess/router/app/hub/feed/availible_challenges_grid.dart';
import 'package:crea_chess/router/app/hub/game/game_page.dart';
import 'package:crea_chess/router/app/user/user_page.dart';
import 'package:crea_chess/router/app/user/widget/user_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
