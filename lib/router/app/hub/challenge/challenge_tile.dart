import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_photo.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/router/app/hub/challenge/card_tile.dart';
import 'package:crea_chess/router/app/hub/game/game_page.dart';
import 'package:crea_chess/router/app/user/user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChallengeTileTemplate extends StatelessWidget {
  const ChallengeTileTemplate({
    required this.userId,
    required this.challenge,
    required this.action,
    super.key,
  });

  final String userId;
  final ChallengeModel challenge;
  final Widget action;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: CCWidgetSize.xxsmall,
      child: CardTile(
        child: Row(
          children: [
            CCGap.small,
            UserPhoto.fromId(
              userId: userId,
              radius: CCSize.medium,
              onTap: () => UserRoute.pushId(userId: userId),
            ),
            CCGap.small,
            const SizedBox(height: CCSize.large, child: VerticalDivider()),
            // CCGap.xsmall,
            // challenge.rule.icon,
            // CCGap.small,
            // const SizedBox(height: CCSize.large, child: VerticalDivider()),
            CCGap.xsmall,
            const Icon(Icons.attach_money),
            CCGap.small,
            Text(challenge.budget.toString()),
            CCGap.small,
            const SizedBox(height: CCSize.large, child: VerticalDivider()),
            CCGap.xsmall,
            Icon(challenge.timeControl.speed.icon),
            CCGap.small,
            Text(challenge.timeControl.toString()),
            CCGap.xsmall,
            const SizedBox(height: CCSize.large, child: VerticalDivider()),
            const Expanded(child: CCGap.small),
            action,
            CCGap.small,
          ],
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    required this.child,
    required this.onPressed,
    super.key,
  });

  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: CCSize.large,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: CCSize.small),
          ),
          backgroundColor: MaterialStateColor.resolveWith(
            (states) => context.colorScheme.surfaceVariant,
          ),
          foregroundColor: MaterialStateColor.resolveWith(
            (states) => context.colorScheme.onBackground,
          ),
        ),
        child: child,
      ),
    );
  }
}

class ChallengeTile extends StatelessWidget {
  const ChallengeTile(this.challenge, {super.key});

  final ChallengeModel challenge;

  @override
  Widget build(BuildContext context) {
    final authUid = context.read<UserCubit>().state.id;
    final authorId = challenge.authorId ?? '';
    if (authorId.isEmpty) return Container(); // corrupted challenge

    return ChallengeTileTemplate(
      userId: authorId,
      challenge: challenge,
      action: (authUid == authorId)
          ? ActionButton(
              onPressed: () => challengeCRUD.delete(documentId: challenge.id),
              child: Text(context.l10n.cancel.toLowerCase()),
            )
          : ActionButton(
              child: Text(
                context.l10n.play.toLowerCase(),
              ),
              onPressed: () => liveGameCRUD.onChallengeAccepted(
                challenge: challenge,
                challengerId: authUid,
              ),
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

    return GestureDetector(
      onTap: enterGame,
      child: ChallengeTileTemplate(
        userId: opponentId,
        challenge: game.challenge,
        action: ActionButton(
          onPressed: enterGame,
          child: const Text('rejoindre'), // TODO : l10n
        ),
      ),
    );
  }
}
