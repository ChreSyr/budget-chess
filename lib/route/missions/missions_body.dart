import 'package:crea_chess/route/route_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MissionsBody extends MainRouteBody {
  const MissionsBody({super.key})
      : super(
          id: 'misions',
          icon: Icons.stars,
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
