import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crea_chess/package/atomic_design/dialog/ok_dialog.dart';
import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/text_style.dart';
import 'package:crea_chess/package/atomic_design/widget/button.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/router/app/hub/challenge/challenge_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChallengeCards extends StatelessWidget {
  const ChallengeCards({super.key});

  @override
  Widget build(BuildContext context) {
    final authUid = context.watch<UserCubit>().state.id;

    return StreamBuilder<Iterable<RelationshipModel>>(
      stream: relationshipCRUD.streamFriendshipsOf(authUid),
      builder: (context, snapshot) {
        final friendships = snapshot.data;
        final friendIds = (friendships == null)
            ? <String>[]
            : friendships
                .map((friendship) => friendship.otherUser(authUid))
                .whereType<String>();

        return StreamBuilder<Iterable<ChallengeModel>>(
          stream: challengeCRUD.streamFiltered(
            filter: (collection) => collection.where(
              Filter('acceptedAt', isNull: true),
            ),
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
                if (myChallenges.isNotEmpty) ...[
                  MyChallengesCard(challenges: myChallenges),
                  CCGap.medium,
                ],
                AvailibleChallengesCard(
                  friendChallenges: friendChallenges,
                  otherChallenges: otherChallenges,
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class MyChallengesCard extends StatelessWidget {
  const MyChallengesCard({required this.challenges, super.key});

  final Iterable<ChallengeModel> challenges;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: CCPadding.allMedium(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    // TODO : l10n
                    "Recherche d'adversaire",
                    style: context.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                CCGap.small,
                if (challenges.length > 1)
                  CompactIconButton(
                    onPressed: () => showOkDialog(
                      pageContext: context,
                      title: null,
                      content: Text(context.l10n.tipChallengesRemoved),
                    ),
                    icon: const Icon(Icons.info_outline),
                  ),
              ],
            ),
            CCGap.medium,
            ...challenges.map(ChallengeTile.new),
          ],
        ),
      ),
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
    return Card(
      child: CCPadding.allMedium(
        child: Column(
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
                  ChallengesTables(challenges: friendChallenges),
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
                    ChallengesTables(challenges: otherChallenges),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
