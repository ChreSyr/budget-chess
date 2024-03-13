import 'package:crea_chess/router/shared/ccroute.dart';
import 'package:crea_chess/router/shared/settings_body.dart';
import 'package:crea_chess/router/sso/signin_body.dart';
import 'package:crea_chess/router/sso/signup_body.dart';
import 'package:crea_chess/router/sso/sso_home_body.dart';
import 'package:go_router/go_router.dart';

final ssoRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, _) =>
          CCRoute.appScaffold(context, const SSOHomeBody()),
      routes: [
        SettingsRoute.goRoute,
        GoRoute(
          path: 'signin',
          builder: (_, __) => CCRoute.appScaffold(_, const SigninBody()),
        ),
        GoRoute(
          path: 'signup',
          builder: (_, __) => CCRoute.appScaffold(_, const SignupBody()),
        ),
      ],
    ),
  ],
);
