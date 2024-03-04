import 'package:crea_chess/route/route_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MissionsBody extends RouteBody {
  const MissionsBody({super.key}) : super(isBottomRoute: true);

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
    return const Center(child: Text('Missions page'));
  }
}
