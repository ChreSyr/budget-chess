import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/router/shared/root_route_body.dart';
import 'package:crea_chess/router/shared/route_body.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CCRoute {
  static Widget appScaffold(BuildContext context, RouteBody body) => Scaffold(
        appBar: AppBar(
          // Sometime, the router goes to a non bottom route, and the nav bar is
          // not shown anymore. In this situation, we need an access to the hub.
          leading: body is! RootRouteBody && !context.canPop()
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
}
