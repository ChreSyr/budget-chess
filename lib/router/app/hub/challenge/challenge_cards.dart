import 'package:crea_chess/package/atomic_design/text_style.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/router/app/chats/chat_home_page.dart';
import 'package:crea_chess/router/app/hub/challenge/challenge_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChallengeCards extends StatelessWidget {
  const ChallengeCards({super.key});

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
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AvailibleChallengesCard(
              friendChallenges: friendChallenges,
              otherChallenges: otherChallenges,
            ),
          ],
        );
      },
    );
  }
}

class AvailibleChallengesCard extends StatelessWidget {
  const AvailibleChallengesCard({
    required this.friendChallenges,
    required this.otherChallenges,
    super.key,
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
        if (friendChallenges.isNotEmpty) ...[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // TODO : l10n : enlever les 2 points
                context.l10n.challengesFromFriends,
                style: context.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              CCGap.medium,
              ChallengesTable(challenges: friendChallenges),
            ],
          ),
          if (otherChallenges.isNotEmpty) CCGap.medium,
        ],
        if (otherChallenges.isNotEmpty || friendChallenges.isEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // TODO : l10n : enlever les 2 points
                context.l10n.challengesFromStrangers,
                style: context.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              CCGap.medium,
              if (otherChallenges.isEmpty)
                const Text("Aucun challenge n'est actuellement disponible.")
              else
                ChallengesTable(challenges: otherChallenges),
            ],
          ),
      ],
    );
  }
}
