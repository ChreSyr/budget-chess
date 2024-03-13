import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/router/app/app_router.dart';
import 'package:crea_chess/router/init_profile/init_profile_router.dart';
import 'package:crea_chess/router/sso/sso_router.dart';
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

    if (auth == null || auth.beingDeleted) {
      return builder(ssoRouter);
    }

    final user = context.watch<UserCubit>().state;

    if (!auth.isVerified || user.id.isEmpty || !user.profileCompleted) {
      return builder(initProfileRouter);
    }

    // The user is correctly logged in, and everyone is happy in this
    // beautiful world
    else {
      if (loggedIn == false) userCRUD.onSignIn(authUid: auth.uid);
      loggedIn = true;
      return builder(appRouter);
    }
  }
}
