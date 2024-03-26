import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/atomic_design/elevation.dart';
import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/text_style.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/router/app/chats/chat_home_page.dart';
import 'package:crea_chess/router/app/hub/game/game_page.dart';
import 'package:crea_chess/router/app/user/user_page.dart';
import 'package:crea_chess/router/app/user/widget/user_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvailibleChallengesGrid extends StatelessWidget {
  const AvailibleChallengesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final authUid = context.watch<UserCubit>().state.id;

    final friendships =
        context.select<RelationsCubit, Iterable<RelationshipModel>>(
      (cubit) => cubit.state.where((relation) => relation.isFriendship),
    );
    final friendIds = friendships
        .map((friendship) => friendship.otherUser(authUid))
        .whereType<String>();

    return StreamBuilder<Iterable<ChallengeModel>>(
      stream: challengeCRUD.streamFiltered(
        filter: (collection) =>
            collection.orderBy('createdAt', descending: true).limit(50),
      ),
      builder: (context, snapshot) {
        final allChallenges = snapshot.data;
        if (allChallenges == null) return CCGap.zero;

        final myChallenges = <ChallengeModel>[];
        final friendChallenges = <ChallengeModel>[];
        final otherChallenges = <ChallengeModel>[];

        final filter = context.watch<ChallengeFilterCubit>().state;

        for (final c in allChallenges) {
          if (c.authorId == authUid) {
            myChallenges.add(c);
          } else if (friendIds.contains(c.authorId)) {
            if (filter == null || filter.accept(c)) {
              friendChallenges.add(c);
            }
          } else if (filter == null || filter.accept(c)) {
            otherChallenges.add(c);
          }
        }
        final sorter = filter ?? ChallengeFilterModel.sorter;
        myChallenges.sort(sorter.compare);
        friendChallenges.sort(sorter.compare);
        otherChallenges.sort(sorter.compare);
        return _AvailibleChallengesGrid(
          friendChallenges: friendChallenges,
          otherChallenges: otherChallenges,
        );
      },
    );
  }
}

class _AvailibleChallengesGrid extends StatelessWidget {
  const _AvailibleChallengesGrid({
    required this.friendChallenges,
    required this.otherChallenges,
  });

  final List<ChallengeModel> friendChallenges;
  final List<ChallengeModel> otherChallenges;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // const ChallengeSorter(), // TODO : when the time will be right
        // CCGap.medium,
        CCGap.medium,
        if (otherChallenges.isEmpty && friendChallenges.isEmpty)
          // TODO : l10n
          const Text("Aucun challenge n'est actuellement disponible."),
        if (friendChallenges.isNotEmpty) ...[
          Text(
            // TODO : l10n : enlever les 2 points
            context.l10n.challengesFromFriends,
            style: context.textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          CCGap.medium,
          ChallengesTable(challenges: friendChallenges),
        ],
        if (otherChallenges.isNotEmpty) ...[
          CCGap.medium,
          ChallengesTable(challenges: otherChallenges),
        ],
      ],
    );
  }
}

class ChallengesTable extends StatelessWidget {
  const ChallengesTable({required this.challenges, super.key});

  final List<ChallengeModel> challenges;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardsPerRow =
            constraints.maxWidth ~/ _ChallengeCardTemplate.minWidth;
        final width = constraints.maxWidth / cardsPerRow;
        final aspectRatio = width / _ChallengeCardTemplate.height;
        return GridView.count(
          crossAxisCount: cardsPerRow,
          childAspectRatio: aspectRatio,
          clipBehavior: Clip.none,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: challenges
              .map(
                (challenge) => SizedBox(
                  // width: CCWidgetSize.large2,
                  child: ChallengeCard(challenge),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class ChallengeCard extends StatelessWidget {
  const ChallengeCard(this.challenge, {super.key});

  final ChallengeModel challenge;

  @override
  Widget build(BuildContext context) {
    final authUid = context.read<UserCubit>().state.id;
    final authorId = challenge.authorId ?? '';
    if (authorId.isEmpty) return Container(); // corrupted challenge

    return _ChallengeCardTemplate(
      userId: authorId,
      challenge: challenge,
      action: (authUid == authorId)
          ? SmallActionButton(
              child: Text(
                context.l10n.cancel.toLowerCase(),
              ),
              onPressed: () => challengeCRUD.delete(documentId: challenge.id),
            )
          : SmallActionButton(
              child: Text(
                context.l10n.play.toLowerCase(),
              ),
              onPressed: () {
                liveGameCRUD.onChallengeAccepted(
                  challenge: challenge,
                  challengerId: authUid,
                );
                GameRoute.push(gameId: challenge.id);
              },
            ),
    );
  }
}

class _ChallengeCardTemplate extends StatelessWidget {
  const _ChallengeCardTemplate({
    required this.userId,
    required this.challenge,
    required this.action,
  });

  final String userId;
  final ChallengeModel challenge;
  final Widget action;

  static const minWidth = CCWidgetSize.medium;
  static const height = CCWidgetSize.small;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: CCElevation.medium,
      color: context.colorScheme.onInverseSurface,
      child: CCPadding.allSmall(
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                UserPhoto.fromId(
                  userId: userId,
                  radius: CCSize.medium,
                  onTap: () => UserRoute.pushId(userId: userId),
                  showConnectedIndicator: true,
                ),
                // CCGap.small,
                // SizedBox(
                //   height: CCSize.xxlarge,
                //   child: VerticalDivider(color: context.colorScheme.onBackground),
                // ),
                // CCGap.xsmall,
                // challenge.rule.icon,
                // CCGap.small,
                // const SizedBox(height: CCSize.large, child: VerticalDivider()),
                CCGap.small,
                const Icon(Icons.attach_money),
                CCGap.xsmall,
                Text(challenge.budget.toString()),
                // CCGap.small,
                // SizedBox(
                //   height: CCSize.xxlarge,
                //   child: VerticalDivider(color: context.colorScheme.onBackground),
                // ),
                // CCGap.small,
                // Icon(challenge.timeControl.speed.icon),
                // CCGap.small,
                // Text(challenge.timeControl.toString()),
              ],
            ),
            const Expanded(child: CCGap.small),
            action,
          ],
        ),
      ),
    );
  }
}

class SmallActionButton extends StatelessWidget {
  const SmallActionButton({
    required this.child,
    required this.onPressed,
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
            (states) => context.colorScheme.primary,
          ),
          foregroundColor: MaterialStateColor.resolveWith(
            (states) => context.colorScheme.onPrimary,
          ),
        ),
        child: child,
      ),
    );
  }
}
