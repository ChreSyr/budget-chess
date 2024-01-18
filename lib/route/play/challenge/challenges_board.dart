import 'package:crea_chess/package/firebase/firestore/challenge/challenge_crud.dart';
import 'package:crea_chess/package/firebase/firestore/challenge/challenge_model.dart';
import 'package:crea_chess/route/play/challenge/challenge_tile.dart';
import 'package:flutter/material.dart';

class ChallengesBoard extends StatelessWidget {
  const ChallengesBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder<Iterable<ChallengeModel>>(
        stream: challengeCRUD.streamAll(),
        builder: (context, snapshot) {
          final challenges = snapshot.data;
          return challenges == null
              ? const Center(child: CircularProgressIndicator())
              : Column(children: challenges.map(ChallengeTile.new).toList());
        },
      ),
    );
  }
}
