import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/route/play/challenge/challenge_sorter.dart';
import 'package:crea_chess/route/play/challenge/challenge_tile.dart';
import 'package:crea_chess/route/play/challenge/my_challenges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChallengesBoard extends StatelessWidget {
  const ChallengesBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, User?>(
      builder: (context, auth) {
        // TODO : FriendshipCubit or Stream friendsOf ?
        return BlocBuilder<FriendshipCubit, Iterable<RelationshipModel>>(
          builder: (context, _) {
            // friendIds uses the state of FriendshipCubit,
            // so we need to place a BlocBuilder above
            final friendIds = context.read<FriendshipCubit>().friendIds;
            return BlocBuilder<ChallengeFilterCubit, ChallengeFilterModel?>(
              builder: (context, filter) {
                return StreamBuilder<Iterable<ChallengeModel>>(
                  stream: challengeCRUD.streamAll(),
                  builder: (context, snapshot) {
                    final allChallenges = snapshot.data?.toList();
                    if (allChallenges == null) {
                      return const CircularProgressIndicator();
                    }
                    final myChallenges = <ChallengeModel>[];
                    final friendChallenges = <ChallengeModel>[];
                    final otherChallenges = <ChallengeModel>[];
                    for (final c in allChallenges) {
                      if (c.authorId == auth?.uid) {
                        myChallenges.add(c);
                      } else if (friendIds.contains(c.authorId)) {
                        if (filter == null || filter.speeds.contains(c.speed)) {
                          friendChallenges.add(c);
                        }
                      } else if (filter == null ||
                          filter.speeds.contains(c.speed)) {
                        otherChallenges.add(c);
                      }
                    }
                    if (filter != null) {
                      myChallenges.sort(filter.compare);
                      friendChallenges.sort(filter.compare);
                      otherChallenges.sort(filter.compare);
                    }
                    return Column(
                      children: [
                        Expanded(
                          child: CCPadding.horizontalLarge(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CCGap.small,
                                  const ChallengeSorter(),
                                  CCGap.small,
                                  const Divider(),
                                  if (friendChallenges.isNotEmpty) ...[
                                    CCPadding.allSmall(
                                      child: const Text(
                                        // TODO : l10n
                                        'Challenges de vos amis :',
                                      ),
                                    ),
                                    ...friendChallenges.map(ChallengeTile.new),
                                    const Divider(),
                                  ],
                                  CCPadding.allSmall(
                                    child:
                                        // TODO : l10n
                                        const Text("Challenges d'étrangers :"),
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
