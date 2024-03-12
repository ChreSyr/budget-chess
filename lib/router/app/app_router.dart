// StatefulShellRoute code from : https://codewithandrea.com/articles/flutter-bottom-navigation-bar-nested-routes-gorouter/
// LATER : responsive scaffold

import 'package:crea_chess/package/atomic_design/border.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/widget/badge.dart';
import 'package:crea_chess/package/atomic_design/widget/nav_bar.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/router/.shared/route_body.dart';
import 'package:crea_chess/router/app/bottom_route_body.dart';
import 'package:crea_chess/router/app/friends/friends_body.dart';
import 'package:crea_chess/router/app/hub/chessground/chessground_body.dart';
import 'package:crea_chess/router/app/hub/create_challenge/create_challenge_body.dart';
import 'package:crea_chess/router/app/hub/game/game_body.dart';
import 'package:crea_chess/router/app/hub/hub_body.dart';
import 'package:crea_chess/router/app/messages/messages_body.dart';
import 'package:crea_chess/router/app/missions/missions_body.dart';
import 'package:crea_chess/router/app/nav_notifier.dart';
import 'package:crea_chess/router/app/route_scaffold.dart';
import 'package:crea_chess/router/.shared/settings_body.dart';
import 'package:crea_chess/router/app/side_routes.dart';
import 'package:crea_chess/router/app/user/modify_username/modify_username_body.dart';
import 'package:crea_chess/router/app/user/user_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHubKey = GlobalKey<NavigatorState>(debugLabel: 'shellHub');
final _shellNavigatorMissionsKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellMissions');
final _shellNavigatorMessagesKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellMesssages');
final _shellNavigatorFriendsKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellFriends');
final _shellNavigatorSettingsKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellSettings');
final _shellNavigatorUserKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellUser');

// TODO : remove this ugly function
Widget buildRoute(BuildContext context, RouteBody body) => Scaffold(
      appBar: AppBar(
        // Sometime, the router goes to a non bottom route, and the nav bar is
        // not shown anymore. In this situation, we need an access to the hub.
        leading: body is! BottomRouteBody && !context.canPop()
            ? IconButton(
                onPressed: () => context.go('/hub'),
                icon: const Icon(Icons.arrow_back),
              )
            : null,
        title: Text(body.getTitle(context.l10n)),
        actions: body.getActions(context),
      ),
      body: body,
    );

// the route when the user user is authenticated and completed his profile
final appRouter = GoRouter(
  initialLocation: '/hub',
  navigatorKey: _rootNavigatorKey,
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
          navigatorKey: _shellNavigatorHubKey,
          routes: [
            // top route inside branch
            GoRoute(
              path: '/hub',
              builder: (context, _) => buildRoute(context, const HubBody()),
              routes: [
                // child routes
                GoRoute(
                  path: 'chessground',
                  builder: (context, state) => const ChessgroundBody(),
                ),
                GoRoute(
                  path: 'create_challenge',
                  builder: (context, _) =>
                      buildRoute(context, const CreateChallengeBody()),
                ),
                GoRoute(
                  path: ':gameId',
                  builder: (context, state) => buildRoute(
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
          navigatorKey: _shellNavigatorMissionsKey,
          routes: [
            // top route inside branch
            GoRoute(
              path: '/missions',
              builder: (context, state) =>
                  const RouteScaffold(body: MissionsBody()),
            ),
          ],
        ),
        // Messages
        StatefulShellBranch(
          navigatorKey: _shellNavigatorMessagesKey,
          routes: [
            // top route inside branch
            GoRoute(
              path: '/messages',
              builder: (context, state) =>
                  const RouteScaffold(body: MessagesBody()),
            ),
          ],
        ),
        // Friends
        StatefulShellBranch(
          navigatorKey: _shellNavigatorFriendsKey,
          routes: [
            // top route inside branch
            GoRoute(
              path: '/friends',
              builder: (context, state) =>
                  const RouteScaffold(body: FriendsBody()),
            ),
          ],
        ),
        // TODO : make the following routes not statefull
        // Settings
        StatefulShellBranch(
          navigatorKey: _shellNavigatorSettingsKey,
          routes: [
            // top route inside branch
            GoRoute(
              path: '/settings',
              builder: (context, state) =>
                  const RouteScaffold(body: SettingsBody()),
            ),
          ],
        ),
        // User
        StatefulShellBranch(
          navigatorKey: _shellNavigatorUserKey,
          routes: [
            // top route inside branch
            GoRoute(
              path: '/user',
              builder: (context, state) =>
                  const RouteScaffold(body: UserBody()),
              routes: [
                // child routes
                GoRoute(
                  path: 'modify_name',
                  builder: (context, state) =>
                      const RouteScaffold(body: ModifyUsernameBody()),
                ),
                GoRoute(
                  path: '@:usernameOrId',
                  builder: (context, state) => RouteScaffold(
                    body: UserBody(
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
          Text(exception?.toString() ?? 'null'),
          TextButton(
            onPressed: () {
              try {
                while (context.canPop()) {
                  context.pop();
                }
              } catch (_) {
                debugPrint('ERROR : Invalid route path');
                context.go('/hub');
              }
            },
            child: Text(context.l10n.back),
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
