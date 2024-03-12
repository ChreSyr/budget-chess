import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/route/app/side_routes.dart';
import 'package:flutter/material.dart';

// TODO : hub_route instead of hub_body

abstract class RouteBody extends StatelessWidget {
  const RouteBody({super.key});

  String getTitle(AppLocalizations l10n);

  List<Widget> getActions(BuildContext context) {
    return [
      const OpenSideRoutesButton(),
      CCGap.small,
    ];
  }
}

class MainRouteData {
  const MainRouteData({
    required this.id,
    required this.icon,
    required this.getTitle,
  });

  final String id;
  final IconData icon;
  final String Function(AppLocalizations l10n) getTitle;
}
