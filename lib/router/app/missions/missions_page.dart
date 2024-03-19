import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/router/shared/app_bar_actions.dart';
import 'package:crea_chess/router/shared/ccroute.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MissionsRoute extends CCRoute {
  const MissionsRoute._() : super(name: '/misssions', icon: Icons.stars);

  /// Instance
  static const i = MissionsRoute._();

  @override
  String getTitle(AppLocalizations l10n) => 'Missions'; // TODO : l10n

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const MissionsPage();
}

class MissionsPage extends StatelessWidget {
  const MissionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MissionsRoute.i.getTitle(context.l10n)),
        actions: getSideRoutesAppBarActions(context),
      ),
      backgroundColor: context.colorScheme.surfaceVariant,
      body: const Center(
        child: Text(
          'Missions page is coming soon ! Only 1 year !\n\nFeel free to make suggestions !\n\nYou can contact the player chresyr ;)',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
