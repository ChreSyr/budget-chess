// StatefulShellRoute code from : https://codewithandrea.com/articles/flutter-bottom-navigation-bar-nested-routes-gorouter/
// LATER : responsive scaffold

import 'package:badges/badges.dart' as badges;
import 'package:crea_chess/package/atomic_design/border.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/widget/nav_bar.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/route/friends/friends_body.dart';
import 'package:crea_chess/route/hub/chessground/chessground_body.dart';
import 'package:crea_chess/route/hub/create_challenge/create_challenge_body.dart';
import 'package:crea_chess/route/hub/game/game_body.dart';
import 'package:crea_chess/route/hub/hub_body.dart';
import 'package:crea_chess/route/messages/messages_body.dart';
import 'package:crea_chess/route/missions/missions_body.dart';
import 'package:crea_chess/route/nav_notifier.dart';
import 'package:crea_chess/route/route_scaffold.dart';
import 'package:crea_chess/route/settings/settings_body.dart';
import 'package:crea_chess/route/side_routes.dart';
import 'package:crea_chess/route/sso/email_verification_body.dart';
import 'package:crea_chess/route/sso/sign_methods_body.dart';
import 'package:crea_chess/route/sso/signin_body.dart';
import 'package:crea_chess/route/sso/signup_body.dart';
import 'package:crea_chess/route/user/modify_username/modify_username_body.dart';
import 'package:crea_chess/route/user/user_body.dart';
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
final _shellNavigatorSSOKey = GlobalKey<NavigatorState>(debugLabel: 'shellSSO');
final _shellNavigatorUserKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellUser');

final _sideRouteDatas = [
            SettingsBody.data,
          ];

// the one and only GoRouter instance
final router = GoRouter(
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
          sideRouteDatas: _sideRouteDatas,
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
              builder: (context, state) => const RouteScaffold(body: HubBody()),
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
        // SSO
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

  static final mainRouteDatas = [
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
    // redirect sso to user
    final selectedIndex = navigationShell.currentIndex;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: selectedIndex >= mainRouteDatas.length
          ? null
          : BlocBuilder<NavNotifCubit, NavNotifs>(
              builder: (context, notifs) {
                return CCNavigationBar(
                  height: CCWidgetSize.xxsmall,
                  selectedIndex: selectedIndex,
                  destinations: mainRouteDatas.map(
                    (route) {
                      final notifCount = notifs.count(routeId: route.id);
                      final icon = badges.Badge(
                        badgeContent: Text(
                          notifCount.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                        position:
                            badges.BadgePosition.topEnd(top: -20, end: -20),
                        badgeAnimation:
                            const badges.BadgeAnimation.fade(toAnimate: false),
                        showBadge: notifCount > 0,
                        child: Icon(route.icon),
                      );
                      return CCNavigationDestination(
                        // icon: icon,
                        icon: SizedBox.square(
                          dimension: CCSize.xxxlarge,
                          child: Center(child: icon),
                        ),
                        selectedIcon: SizedBox.square(
                          dimension: CCSize.xxxlarge,
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
