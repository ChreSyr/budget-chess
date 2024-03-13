import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/router/init_profile/init_photo_body.dart';
import 'package:crea_chess/router/init_profile/init_profile_home_body.dart';
import 'package:crea_chess/router/init_profile/init_username_body.dart';
import 'package:crea_chess/router/shared/route_body.dart';
import 'package:crea_chess/router/shared/settings_body.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// TODO : remove this ugly function
Widget buildRoute(BuildContext context, GoRouterState _, RouteBody body) =>
    Scaffold(
      appBar: AppBar(
        title: Text(body.getTitle(context.l10n)),
        actions: body.getActions(context),
      ),
      body: body,
    );

final initProfileRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, _) =>
          buildRoute(context, _, const InitProfileHomeBody()),
      routes: [
        GoRoute(
          path: 'settings',
          builder: (_, __) => buildRoute(_, __, const SettingsBody()),
        ),
        GoRoute(
          path: 'username',
          builder: (_, __) => buildRoute(_, __, const InitUsernameBody()),
        ),
        GoRoute(
          path: 'photo',
          builder: (_, __) => buildRoute(_, __, const InitPhotoBody()),
        ),
      ],
    ),
  ],
);
