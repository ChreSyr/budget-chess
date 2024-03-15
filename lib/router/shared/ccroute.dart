import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class CCRoute {
  const CCRoute({
    required this.name,
    String? path,
    this.icon = Icons.cancel,
  }) : path = path ?? (name == 'home' ? '/' : name);

  final String name;
  final String path;
  final IconData icon;

  List<RouteBase> get routes => [];

  GoRoute get goRoute => GoRoute(
        name: name,
        path: path,
        builder: build,
        routes: routes,
      );

  String getTitle(AppLocalizations l10n) => '';

  Widget build(BuildContext context, GoRouterState state);
}

extension GoRouterInitialLoc on GoRouter {
  void goHome() => go('/');
}

extension GoRouterSafer on BuildContext {
  void pushRoute(CCRoute route) => GoRouter.of(this).pushNamed(route.name);
  void goHome() => go('/');
}
