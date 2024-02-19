// Code from : https://codewithandrea.com/articles/flutter-bottom-navigation-bar-nested-routes-gorouter/
// LATER : responsive scaffold

import 'package:badges/badges.dart' as badges;
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/route/nav_notif_cubit.dart';
import 'package:crea_chess/route/play/chessground/chessground_body.dart';
import 'package:crea_chess/route/play/create_challenge/create_challenge_body.dart';
import 'package:crea_chess/route/play/game/game_body.dart';
import 'package:crea_chess/route/play/play_body.dart';
import 'package:crea_chess/route/route_scaffold.dart';
import 'package:crea_chess/route/settings/settings_body.dart';
import 'package:crea_chess/route/user/modify_username/modify_username_body.dart';
import 'package:crea_chess/route/user/sso/email_verification_body.dart';
import 'package:crea_chess/route/user/sso/sign_methods_body.dart';
import 'package:crea_chess/route/user/sso/signin_body.dart';
import 'package:crea_chess/route/user/sso/signup_body.dart';
import 'package:crea_chess/route/user/user_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');
final _shellNavigatorCKey = GlobalKey<NavigatorState>(debugLabel: 'shellC');
final _shellNavigatorSSOKey = GlobalKey<NavigatorState>(debugLabel: 'shellSSO');

// the one and only GoRouter instance
final router = GoRouter(
  initialLocation: '/play',
  navigatorKey: _rootNavigatorKey,
  errorBuilder: (context, state) => ErrorPage(exception: state.error),
  routes: [
    // Stateful nested navigation based on:
    // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // the UI shell
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAKey,
          routes: [
            // top route inside branch
            GoRoute(
              path: '/play',
              builder: (context, state) =>
                  const RouteScaffold(body: HomeBody()),
              routes: [
                // child routes
                GoRoute(
                  path: 'chessground',
                  builder: (context, state) => const ChessgroundBody(),
                ),
                GoRoute(
                  path: 'create_challenge',
                  builder: (context, state) =>
                      const RouteScaffold(body: CreateChallengeBody()),
                ),
                GoRoute(
                  path: 'game',
                  builder: (context, state) =>
                      RouteScaffold(body: GameBody.games()),
                  routes: [
                    GoRoute(
                      path: ':gameId',
                      builder: (context, state) => RouteScaffold(
                        body: GameBody(
                          gameId: state.pathParameters['gameId'] ?? 'none',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorBKey,
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
        StatefulShellBranch(
          navigatorKey: _shellNavigatorCKey,
          routes: [
            // top route inside branch
            GoRoute(
              path: '/settings',
              builder: (context, state) =>
                  const RouteScaffold(body: SettingsBody()),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorSSOKey,
          routes: [
            // top route inside branch
            GoRoute(
              path: '/sso',
              builder: (context, state) =>
                  const RouteScaffold(body: SignMethodsBody()),
              routes: [
                // child routes
                GoRoute(
                  path: 'signin',
                  builder: (context, state) =>
                      const RouteScaffold(body: SigninBody()),
                ),
                GoRoute(
                  path: 'signup',
                  builder: (context, state) =>
                      const RouteScaffold(body: SignupBody()),
                ),
                GoRoute(
                  path: 'email_verification',
                  builder: (context, state) =>
                      const RouteScaffold(body: EmailVerificationBody()),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

final mainRouteBodies = [
  const HomeBody(),
  const UserBody(),
  const SettingsBody(),
];

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
                context.go('/play');
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
    // redirect sso to user
    final selectedIndex = navigationShell.currentIndex;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: selectedIndex >= mainRouteBodies.length
          ? null
          : BlocBuilder<NavNotifCubit, Map<String, Set<String>>>(
              builder: (context, notifs) {
                return NavigationBar(
                  height: CCWidgetSize.xxsmall,
                  selectedIndex: selectedIndex,
                  destinations: mainRouteBodies
                      .map(
                        (e) => NavigationDestination(
                          icon: notifs[e.id]?.isNotEmpty ?? false
                              ? badges.Badge(child: Icon(e.icon))
                              : Icon(e.icon),
                          label: e.getTitle(context.l10n),
                        ),
                      )
                      .toList(),
                  onDestinationSelected: _goBranch,
                );
              },
            ),
    );
  }
}
