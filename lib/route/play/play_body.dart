import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/route/play/challenge/challenges_board.dart';
import 'package:crea_chess/route/route_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class HomeBody extends MainRouteBody {
  const HomeBody({super.key})
      : super(
          id: 'home',
          icon: Icons.play_arrow,
          scrolled: false,
        );

  @override
  String getTitle(AppLocalizations l10n) {
    return l10n.play;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: CCWidgetSize.large4,
      child: Column(
        children: [
          const Expanded(child: ChallengesBoard()),
          CCGap.large,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: () => context.go('/play/chessground'),
                child: const Text('Play'),
              ),
              CCGap.large,
              FilledButton.icon(
                onPressed: () => context.go('/play/create_challenge'),
                icon: const Icon(Icons.add),
                label: const Text('Create challenge'),
              ),
            ],
          ),
          CCGap.large,
        ],
      ),
    );
  }
}
