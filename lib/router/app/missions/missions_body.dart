import 'package:crea_chess/router/app/bottom_route_body.dart';
import 'package:crea_chess/router/shared/route_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MissionsBody extends BottomRouteBody {
  const MissionsBody({super.key});

  static final MainRouteData data = MainRouteData(
    id: 'misions',
    icon: Icons.stars,
    getTitle: (l10n) => 'Missions', // TODO : l10n
  );

  @override
  String getTitle(AppLocalizations l10n) {
    return 'Missions'; // TODO : l10n
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Missions page is coming soon ! Only 1 year !\n\nFeel free to make suggestions !\n\nYou can contact the player chresyr ;)',
        textAlign: TextAlign.center,
      ),
    );
  }
}
