import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/route/play/challenge/authored_challenges.dart';
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
                          if (filter == null ||
                              filter.speed.contains(c.speed)) {
                            friendChallenges.add(c);
                          }
                        } else if (filter == null ||
                            filter.speed.contains(c.speed)) {
                          otherChallenges.add(c);
                        }
                      }
                      if (filter != null) {
                      myChallenges.sort(filter.compare);
                      friendChallenges.sort(filter.compare);
                      otherChallenges.sort(filter.compare);
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (myChallenges.isNotEmpty) ...[
                            AuthoredChallenges(myChallenges: myChallenges),
                            const Divider(),
                          ],
                          if (friendChallenges.isNotEmpty) ...[
                            CCPadding.allSmall(
                              child: const Text('Challenges de vos amis :'),
                            ),
                            ...friendChallenges.map(ChallengeTile.new),
                            const Divider(),
                          ],
                          CCPadding.allSmall(
                            child: const Text("Challenges d'étrangers :"),
                          ),
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
