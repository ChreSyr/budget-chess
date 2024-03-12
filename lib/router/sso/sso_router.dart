import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/router/.shared/route_body.dart';
import 'package:crea_chess/router/sso/signin_body.dart';
import 'package:crea_chess/router/sso/signup_body.dart';
import 'package:crea_chess/router/sso/sso_home_body.dart';
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

final ssoRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, _) => buildRoute(context, _, const SSOHomeBody()),
      routes: [
        GoRoute(
          path: 'signin',
          builder: (_, __) => buildRoute(_, __, const SigninBody()),
        ),
        GoRoute(
          path: 'signup',
          builder: (_, __) => buildRoute(_, __, const SignupBody()),
        ),
      ],
    ),
  ],
);
