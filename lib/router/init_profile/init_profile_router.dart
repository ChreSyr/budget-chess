import 'package:crea_chess/router/init_profile/init_photo_body.dart';
import 'package:crea_chess/router/init_profile/init_profile_home_body.dart';
import 'package:crea_chess/router/init_profile/init_username_body.dart';
import 'package:crea_chess/router/shared/ccroute.dart';
import 'package:crea_chess/router/shared/settings_body.dart';
import 'package:go_router/go_router.dart';

final initProfileRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, _) =>
          CCRoute.appScaffold(context, const InitProfileHomeBody()),
      routes: [
        SettingsRoute.goRoute,
        GoRoute(
          path: 'username',
          builder: (_, __) => CCRoute.appScaffold(_, const InitUsernameBody()),
        ),
        GoRoute(
          path: 'photo',
          builder: (_, __) => CCRoute.appScaffold(_, const InitPhotoBody()),
        ),
      ],
    ),
  ],
);
