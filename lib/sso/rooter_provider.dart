import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/route/route_body.dart';
import 'package:crea_chess/route/router.dart';
import 'package:crea_chess/sso/email_verification_body.dart';
import 'package:crea_chess/sso/emergency_app_bar.dart';
import 'package:crea_chess/sso/profile_completer.dart';
import 'package:crea_chess/sso/sign_methods_body.dart';
import 'package:crea_chess/sso/signin_body.dart';
import 'package:crea_chess/sso/signup_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// ignore: must_be_immutable
class RouterProvider extends StatelessWidget {
  RouterProvider({required this.builder, super.key});

  final Widget Function(GoRouter) builder;

  bool loggedIn = false;

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthNotVerifiedCubit>().state;
    final user = context.watch<UserCubit>().state;

    print('User : $user');

    final RouteBody body;

    // The user is not logged in
    if (auth == null) {
      body = const SignMethodsBody();
    } else

    // The user just asked to delete its account.
    if (auth.displayName == accountBeingDeleted) {
      body = const DeletingAccountPage();
    } else

    // The user logged in via address email but didn't confirm that he
    // actually is the owner of this address email
    if (!auth.isVerified) {
      body = const EmailVerificationBody();
    } else

    // Only happen when UserCubit stores _noAccountInFirebase.
    // The user is logged in and verified his address, but no
    // corresponding data exists in firestore yet. This means the user
    // just created his account
    if (user.id.isEmpty && user.username == 'noAccountInFirebase') {
      userCRUD.onAccountCreation(auth);
      body = const CreatingAccountPage();
    } else

    // Only happen when UserCubit stores _userUnauthenticated.
    // The user is logged in and verified his address, we are waiting for
    // firebase to return a UserModel
    if (user.id.isEmpty && user.username == 'userUnauthenticated') {
      body = const LoadingAccountPage();
    } else

    // The user is correctly logged in, but he didn't initialized his
    // account yet (with a username for example)
    if (!user.profileCompleted) {
      body = const ProfileCompleter();
    }

    // The user is correctly logged in, and everyone is happy in this
    // beautiful world
    else {
      if (loggedIn == false) userCRUD.onSignIn(authUid: auth.uid);
      loggedIn = true;
      return builder(authenticatedRouter);
    }

    loggedIn = false;

    Widget buildRoute(BuildContext context, GoRouterState _, RouteBody body) =>
        Scaffold(
          appBar: AppBar(
            title: Text(body.getTitle(context.l10n)),
            actions: body.getActions(context),
          ),
          body: body,
        );

    final unauthenticatedRouter = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, _) => buildRoute(context, _, body),
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

    return builder(unauthenticatedRouter);
  }
}

class CreatingAccountPage extends RouteBody {
  const CreatingAccountPage({super.key});

  @override
  List<Widget> getActions(BuildContext context) =>
      getEmergencyAppBarActions(context);

  @override
  String getTitle(AppLocalizations l10n) => '';

  @override
  Widget build(BuildContext context) {
    // TODO
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Creating your account'),
          CCGap.small,
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}

class LoadingAccountPage extends RouteBody {
  const LoadingAccountPage({super.key});

  @override
  List<Widget> getActions(BuildContext context) =>
      getEmergencyAppBarActions(context);

  @override
  String getTitle(AppLocalizations l10n) => '';

  @override
  Widget build(BuildContext context) {
    // TODO
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Loading your account'),
          CCGap.small,
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}

class DeletingAccountPage extends RouteBody {
  const DeletingAccountPage({super.key});

  @override
  List<Widget> getActions(BuildContext context) => [];

  @override
  String getTitle(AppLocalizations l10n) => '';

  @override
  Widget build(BuildContext context) {
    // TODO
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Deleting your account'),
          CCGap.small,
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
