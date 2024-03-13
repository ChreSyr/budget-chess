// StatefulShellRoute code from : https://codewithandrea.com/articles/flutter-bottom-navigation-bar-nested-routes-gorouter/
// LATER : responsive scaffold

import 'package:crea_chess/package/atomic_design/border.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/widget/badge.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/atomic_design/widget/nav_bar.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/router/app/friends/friends_body.dart';
import 'package:crea_chess/router/app/hub/chessground/chessground_body.dart';
import 'package:crea_chess/router/app/hub/create_challenge/create_challenge_body.dart';
import 'package:crea_chess/router/app/hub/game/game_body.dart';
import 'package:crea_chess/router/app/hub/hub_body.dart';
import 'package:crea_chess/router/app/messages/messages_body.dart';
import 'package:crea_chess/router/app/missions/missions_body.dart';
import 'package:crea_chess/router/app/nav_notifier.dart';
import 'package:crea_chess/router/app/side_routes.dart';
import 'package:crea_chess/router/app/user/modify_username_body.dart';
import 'package:crea_chess/router/app/user/user_body.dart';
import 'package:crea_chess/router/shared/ccroute.dart';
import 'package:crea_chess/router/shared/settings_body.dart';
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
        // Hub
        StatefulShellBranch(
          routes: [
            // top route inside branch
            GoRoute(
              path: '/hub',
              builder: (context, _) =>
                  CCRoute.appScaffold(context, const HubBody()),
              routes: [
                // child routes
                GoRoute(
                  path: 'chessground',
                  builder: (context, state) => const ChessgroundBody(),
                ),
                GoRoute(
                  path: 'create_challenge',
                  builder: (context, _) =>
                      CCRoute.appScaffold(context, const CreateChallengeBody()),
                ),
                GoRoute(
                  path: ':gameId',
                  builder: (context, state) => CCRoute.appScaffold(
                    context,
                    GameBody(
                      gameId: state.pathParameters['gameId'] ?? 'none',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        // Missions
        StatefulShellBranch(
          routes: [
            // top route inside branch
            GoRoute(
              path: '/missions',
              builder: (context, state) =>
                  CCRoute.appScaffold(context, const MissionsBody()),
            ),
          ],
        ),
        // Messages
        StatefulShellBranch(
          routes: [
            // top route inside branch
            GoRoute(
              path: '/messages',
              builder: (context, state) =>
                  CCRoute.appScaffold(context, const MessagesBody()),
            ),
          ],
        ),
        // Friends
        StatefulShellBranch(
          routes: [
            // top route inside branch
            GoRoute(
              path: '/friends',
              builder: (context, state) =>
                  CCRoute.appScaffold(context, const FriendsBody()),
            ),
          ],
        ),
        // Other routes
        StatefulShellBranch(
          routes: [
            // top route inside branch
            GoRoute(
              path: '/',
              builder: (context, state) => const ErrorPage(exception: null),
              routes: [
                // Settings
                SettingsRoute.goRoute,
                // User profile
                GoRoute(
                  path: 'user',
                  builder: (context, state) =>
                      CCRoute.appScaffold(context, const UserBody()),
                  routes: [
                    // child routes
                    GoRoute(
                      path: 'modify_name',
                      builder: (context, state) => CCRoute.appScaffold(
                        context,
                        const ModifyUsernameBody(),
                      ),
                    ),
                    GoRoute(
                      path: '@:usernameOrId',
                      builder: (context, state) => CCRoute.appScaffold(
                        context,
                        UserBody(
                          usernameOrId: state.pathParameters['usernameOrId'],
                        ),
                      ),
                    ),
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
            onPressed: () => context.go('/hub'),
            icon: Icon(HubBody.data.icon),
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

  static final bottomRouteDatas = [
    HubBody.data,
    MissionsBody.data,
    MessagesBody.data,
    FriendsBody.data,
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
      bottomNavigationBar: selectedIndex >= bottomRouteDatas.length
          ? null
          : BlocBuilder<NavNotifCubit, NavNotifs>(
              builder: (context, notifs) {
                return CCNavigationBar(
                  height: CCWidgetSize.xxsmall,
                  selectedIndex: selectedIndex,
                  destinations: bottomRouteDatas.map(
                    (route) {
                      final notifCount = notifs.count(routeId: route.id);
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
