import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/firebase/firestore/challenge/challenge_model.dart';
import 'package:crea_chess/route/play/challenge/card_tile.dart';
import 'package:crea_chess/route/play/challenge/challenge_tile.dart';
import 'package:flutter/material.dart';

class AuthoredChallenges extends StatefulWidget {
  const AuthoredChallenges({required this.myChallenges, super.key});

  final Iterable<ChallengeModel> myChallenges;

  @override
  State<AuthoredChallenges> createState() => _AuthoredChallengesState();
}

class _AuthoredChallengesState extends State<AuthoredChallenges> {
  bool showChallenges = false;

  @override
  Widget build(BuildContext context) {
    void onTap() => setState(() => showChallenges = !showChallenges);
    return Column(
      children: [
        CardTile(
          onTap: onTap,
          child: Row(
            children: [
              CCGap.medium,
              Text(
                // TODO : l10n
                'Vous avez créé ${widget.myChallenges.length} challenges.',
              ),
              const Expanded(child: CCGap.small),
              IconButton(
                icon: Icon(
                  showChallenges ? Icons.expand_less : Icons.expand_more,
                ),
                onPressed: onTap,
              ),
            ],
          ),
        ),
        if (showChallenges) ...widget.myChallenges.map(ChallengeTile.new),
        if (showChallenges && widget.myChallenges.length > 1) ...[
          CCGap.small,
          const Row(
            children: [
              Icon(Icons.info_outline),
              CCGap.small,
              Expanded(
                child: Text(
                  "Dès qu'un de vos challenges sera accepté, tout les autres seront supprimés",
                ),
              ),
            ],
          ),
          CCGap.xsmall,
        ],
      ],
    );
  }
}
