import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/firebase/authentication/authentication_crud.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_crud.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_cubit.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/router/init_profile/email_verification_screen.dart';
import 'package:crea_chess/router/shared/emergency_app_bar.dart';
import 'package:crea_chess/router/shared/route_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class InitProfileHomeBody extends RouteBody {
  const InitProfileHomeBody({super.key});

  @override
  String getTitle(AppLocalizations l10n) => '';

  @override
  List<Widget> getActions(BuildContext context) =>
      getEmergencyAppBarActions(context);
  
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
              onPressed: () => context.push('/username'),
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
