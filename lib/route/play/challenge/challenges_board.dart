import 'package:crea_chess/package/firebase/authentication/authentication_crud.dart';
import 'package:crea_chess/package/firebase/firestore/challenge/challenge_crud.dart';
import 'package:crea_chess/package/firebase/firestore/challenge/challenge_model.dart';
import 'package:crea_chess/package/firebase/firestore/relationship/cubit/friendships_cubit.dart';
import 'package:crea_chess/package/firebase/firestore/relationship/relationship_model.dart';
import 'package:crea_chess/route/play/challenge/authored_challenges.dart';
import 'package:crea_chess/route/play/challenge/challenge_sorter_cubit.dart';
import 'package:crea_chess/route/play/challenge/challenge_sorter_state.dart';
import 'package:crea_chess/route/play/challenge/challenge_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChallengesBoard extends StatelessWidget {
  const ChallengesBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, User?>(
      builder: (context, auth) {
        return SingleChildScrollView(
          // TODO : FriendshipCubit or Stream friendsOf ?
          child: BlocBuilder<FriendshipCubit, Iterable<RelationshipModel>>(
            builder: (context, _) {
              // friendIds uses the state of FriendshipCubit,
              // so we need to place a BlocBuilder above
              final friendIds = context.read<FriendshipCubit>().friendIds;
              return BlocBuilder<ChallengeSorterCubit, ChallengeSorterState>(
                builder: (context, sorter) {
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
                          friendChallenges.add(c);
                        } else if (sorter.speed == null ||
                            c.speed == sorter.speed) {
                          otherChallenges.add(c);
                        }
                      }
                      myChallenges.sort(sorter.compare);
                      friendChallenges.sort(sorter.compare);
                      otherChallenges.sort(sorter.compare);
                      return Column(
                        children: [
                          if (myChallenges.isNotEmpty) ...[
                            AuthoredChallenges(myChallenges: myChallenges),
                            const Divider(),
                          ],
                          if (friendChallenges.isNotEmpty) ...[
                            ...friendChallenges.map(ChallengeTile.new),
                            const Divider(),
                          ],
                          ...otherChallenges.map(ChallengeTile.new),
                        ],
                      );
                    },
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
