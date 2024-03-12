import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/router/app/hub/challenge/challenge_sorter.dart';
import 'package:crea_chess/router/app/hub/challenge/challenge_tile.dart';
import 'package:crea_chess/router/app/hub/challenge/my_challenges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChallengesBoard extends StatelessWidget {
  const ChallengesBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserModel>(
      builder: (context, auth) {
        final authUid = auth.id;
        return StreamBuilder<Iterable<RelationshipModel>>(
          stream: relationshipCRUD.friendshipsOf(authUid),
          builder: (context, snapshot) {
            final friendships = snapshot.data;
            final friendIds = (friendships == null)
                ? <String>[]
                : friendships
                    .map((friendship) => friendship.otherUser(authUid))
                    .whereType<String>();
            return BlocBuilder<ChallengeFilterCubit, ChallengeFilterModel?>(
              builder: (context, filter) {
                return StreamBuilder<Iterable<ChallengeModel>>(
                  stream: challengeCRUD.streamFiltered(
                    filter: (collection) => collection.where(
                      Filter(
                        'acceptedAt',
                        isNull: true,
                      ),
                    ),
                  ),
                  builder: (context, snapshot) {
                    final allChallenges = snapshot.data?.toList();
                    if (allChallenges == null) {
                      return Container();
                    }
                    final myChallenges = <ChallengeModel>[];
                    final friendChallenges = <ChallengeModel>[];
                    final otherChallenges = <ChallengeModel>[];
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
                      children: [
                        Expanded(
                          child: CCPadding.horizontalLarge(
                            child: SingleChildScrollView(
                              clipBehavior: Clip.none,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CCGap.small,
                                  const ChallengeSorter(),
                                  CCGap.small,
                                  const Divider(),
                                  if (friendChallenges.isNotEmpty) ...[
                                    CCPadding.allSmall(
                                      child: Text(
                                        context.l10n.challengesFromFriends,
                                      ),
                                    ),
                                    ...friendChallenges.map(ChallengeTile.new),
                                    const Divider(),
                                  ],
                                  CCPadding.allSmall(
                                    child: Text(
                                      context.l10n.challengesFromStrangers,
                                    ),
                                  ),
                                  ...otherChallenges.map(ChallengeTile.new),
                                ],
                              ),
                            ),
                          ),
                        ),
                        MyChallenges(myChallenges: myChallenges),
                      ],
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
