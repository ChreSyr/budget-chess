import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/router/app/side_routes.dart';
import 'package:crea_chess/router/shared/ccroute.dart';
import 'package:crea_chess/router/shared/settings/settings_page.dart';
import 'package:flutter/material.dart';

List<Widget> getSideRoutesAppBarActions(BuildContext context) => const [
      OpenSideRoutesButton(),
      CCGap.small,
    ];

List<Widget> getSettingsAppBarActions(BuildContext context) => [
      IconButton(
        onPressed: () => context.pushRoute(SettingsRoute.i),
        icon: const Icon(Icons.settings),
      ),
    ];
