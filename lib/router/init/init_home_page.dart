import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/firebase/authentication/authentication_crud.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_crud.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_cubit.dart';
import 'package:crea_chess/router/init/email_verification_screen.dart';
import 'package:crea_chess/router/init/photo/init_photo_page.dart';
import 'package:crea_chess/router/init/username/init_username_page.dart';
import 'package:crea_chess/router/shared/app_bar_actions.dart';
import 'package:crea_chess/router/shared/ccroute.dart';
import 'package:crea_chess/router/shared/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class InitHomeRoute extends CCRoute {
  const InitHomeRoute._() : super(name: 'home');

  /// Instance
  static const i = InitHomeRoute._();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const InitHomePage();

  @override
  List<RouteBase> get routes => [
        SettingsRoute.i.goRoute,
        InitUsernameRoute.i.goRoute,
        InitPhotoRoute.i.goRoute,
      ];
}

class InitHomePage extends StatelessWidget {
  const InitHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: getSettingsAppBarActions(context)),
      body: const _InitHomePage(),
    );
  }
}

class _InitHomePage extends StatelessWidget {
  const _InitHomePage();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthNotVerifiedCubit>().state;

    // The user just logged out, the application will change router
    if (auth == null) return const Center(child: CircularProgressIndicator());

    // The user just created its account but didn't prove he owns the email yet
    if (!auth.isVerified) return const EmailVerificationScreen();

    final user = context.watch<UserCubit>().state;

    if (user.id.isEmpty) {
      // Only happen when UserCubit stores _noAccountInFirebase.
      // The user is logged in and verified his address, but no
      // corresponding data exists in firestore yet. This means the user
      // just created his account
      if (user.username == 'noAccountInFirebase') {
        userCRUD.onAccountCreation(auth);
        return const Center(
          child: Column(
            children: [
              Text('Compte en cours de création'), // TODO : l10n
              CCGap.medium,
              LinearProgressIndicator(),
            ],
          ),
        );
      }

      // Only happen when the user is logged in and verified his address, but we
      // are waiting for firebase to return a UserModel
      return const Center(child: CircularProgressIndicator());
    }

    // The user is correctly logged in, but he didn't initialized his
    // account yet (with a username for example)
    if (!user.profileCompleted) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Bienvenue sur Budget Chess !'), // TODO : l10n
            CCGap.medium,
            FilledButton(
              onPressed: () => context.pushRoute(InitUsernameRoute.i),
              child: const Text("C'est parti !"), // TODO : l10n
            ),
          ],
        ),
      );
    }

    // The user initialized his account, the application will change router
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
