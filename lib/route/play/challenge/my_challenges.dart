import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/route/play/challenge/challenge_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyChallenges extends StatelessWidget {
  const MyChallenges({required this.myChallenges, super.key});

  final Iterable<ChallengeModel> myChallenges;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.grey, //New
            blurRadius: 25,
            offset: Offset(0, -10),
          ),
        ],
        color: CCColor.background(context),
      ),
      child: CCPadding.horizontalLarge(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CCGap.small,
            if (myChallenges.isNotEmpty) ...[
              CCGap.small,
              const Text(
                // TODO : l10n
                'Waiting for an opponent...',
                textAlign: TextAlign.center,
              ),
              CCGap.small,
              ...myChallenges.map(ChallengeTile.new),
            ],
            if (myChallenges.length > 1) ...[
              CCGap.medium,
              const Row(
                children: [
                  Icon(Icons.info_outline),
                  CCGap.small,
                  Expanded(
                    child: Text(
                      // TODO : l10n
                      // TODO : tips
                      "Dès qu'un de vos challenges sera accepté, tout les autres seront supprimés",
                    ),
                  ),
                ],
              ),
            ],
            CCGap.medium,
            FilledButton.icon(
              onPressed: () => context.go('/play/create_challenge'),
              icon: const Icon(Icons.add),
              label: const Text('Create challenge'),
            ),
            CCGap.large,
          ],
        ),
      ),
    );
  }
}
