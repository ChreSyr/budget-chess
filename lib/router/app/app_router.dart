// StatefulShellRoute code from : https://codewithandrea.com/articles/flutter-bottom-navigation-bar-nested-routes-gorouter/
// LATER : responsive scaffold

import 'package:crea_chess/package/atomic_design/border.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/widget/badge.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/atomic_design/widget/nav_bar.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/router/app/friends/friends_page.dart';
import 'package:crea_chess/router/app/hub/hub_page.dart';
import 'package:crea_chess/router/app/messages/messages_page.dart';
import 'package:crea_chess/router/app/missions/missions_page.dart';
import 'package:crea_chess/router/app/nav_notifier.dart';
import 'package:crea_chess/router/app/side_routes.dart';
import 'package:crea_chess/router/app/user/modify_username_page.dart';
import 'package:crea_chess/router/app/user/user_page.dart';
import 'package:crea_chess/router/shared/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// the route when the user user is authenticated and completed his profile
final appRouter = GoRouter(
  initialLocation: '/hub',
  errorBuilder: (context, state) => ErrorPage(exception: state.error),
  routes: [
    // Stateful nested navigation based on:
    // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // the UI shell
        return SideRoutes(
          child: ScaffoldWithNestedNavigation(navigationShell: navigationShell),
        );
      },
      branches: [
        // Bottom routes : hub, missions, messages & friends
        StatefulShellBranch(routes: [HubRoute.i.goRoute]),
        StatefulShellBranch(routes: [MissionsRoute.i.goRoute]),
        StatefulShellBranch(routes: [MessagesRoute.i.goRoute]),
        StatefulShellBranch(routes: [FriendsRoute.i.goRoute]),
        // Other routes
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const ErrorPage(exception: null),
              routes: [
                SettingsRoute.i.goRoute,
                GoRoute(
                  path: 'user',
                  builder: (context, state) => const UserPage(),
                  routes: [
                    ModifyUsernameRoute.i.goRoute,
                    UserRoute.i.goRoute,
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

class ErrorPage extends StatelessWidget {
  const ErrorPage({required this.exception, super.key});

  final Exception? exception;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page not found')),
      body: ErrorBody(exception: exception),
    );
  }
}

class ErrorBody extends StatelessWidget {
  const ErrorBody({required this.exception, super.key});

  final Exception? exception;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Error : $exception'),
          CCGap.medium,
          FilledButton.icon(
            onPressed: () => context.goNamed(HubRoute.i.name),
            icon: Icon(HubRoute.i.icon),
            label: Text(context.l10n.hub),
          ),
        ],
      ),
    );
  }
}

// Stateful nested navigation based on:
// https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({required this.navigationShell, Key? key})
      : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));

  final StatefulNavigationShell navigationShell;

  static final bottomRoutes = [
    HubRoute.i,
    MissionsRoute.i,
    MessagesRoute.i,
    FriendsRoute.i,
  ];

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = navigationShell.currentIndex;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: selectedIndex >= bottomRoutes.length
          ? null
          : BlocBuilder<NavNotifCubit, NavNotifs>(
              builder: (context, notifs) {
                return CCNavigationBar(
                  height: CCWidgetSize.xxsmall,
                  selectedIndex: selectedIndex,
                  destinations: bottomRoutes.map(
                    (route) {
                      final notifCount = notifs.count(routeName: route.name);
                      final icon = CountBadge(
                        count: notifCount,
                        child: Icon(route.icon),
                      );
                      return CCNavigationDestination(
                        // icon: icon,
                        icon: SizedBox.square(
                          dimension: CCWidgetSize.xsmall,
                          child: Center(child: icon),
                        ),
                        selectedIcon: SizedBox.square(
                          dimension: CCWidgetSize.xsmall,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              icon,
                              Text(route.getTitle(context.l10n)),
                            ],
                          ),
                        ),
                        label: route.getTitle(context.l10n),
                      );
                    },
                  ).toList(),
                  onDestinationSelected: _goBranch,
                  labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                  indicatorSize: const Size(86, 54),
                  indicatorShape: const RoundedRectangleBorder(
                    borderRadius: CCBorderRadiusCircular.medium,
                  ),
                  overlayColor: MaterialStateColor.resolveWith(
                    (states) => Colors.transparent,
                  ),
                );
              },
            ),
    );
  }
}
