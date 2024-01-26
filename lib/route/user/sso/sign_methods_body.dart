import 'package:crea_chess/package/atomic_design/border.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/snack_bar.dart';
import 'package:crea_chess/package/atomic_design/widget/divider.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/firebase/authentication/authentication_crud.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/route/route_body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignMethodsBody extends RouteBody {
  const SignMethodsBody({super.key});

  @override
  String getTitle(AppLocalizations l10n) => '';

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, User?>(
      listener: (context, user) {
        if (user != null && context.canPop()) context.pop();
      },
      child: SizedBox(
        width: CCWidgetSize.large4,
        child: ListView(
          shrinkWrap: true,
          children: [
            // sign in button
            FilledButton(
              onPressed: () => context.push('/sso/signin'),
              child: Text(context.l10n.signin),
            ),

            CCGap.small,

            // sign up button
            FilledButton(
              onPressed: () => context.push('/sso/signup'),
              child: Text(context.l10n.signup),
            ),

            CCGap.medium,

            // or continue with
            Row(
              children: [
                Expanded(child: CCDivider.xthin),
                CCGap.small,
                Text(context.l10n.orContinueWith),
                CCGap.small,
                Expanded(child: CCDivider.xthin),
              ],
            ),
            CCGap.medium,

            // google or facebook loading animation
            BlocConsumer<AuthProviderStatusCubit, AuthProviderStatus>(
              listener: (context, status) {
                if (status == AuthProviderStatus.error) {
                  snackBarError(context, context.l10n.errorOccurred);
                }
              },
              builder: (context, status) {
                if (status == AuthProviderStatus.waiting) {
                  return const Column(
                    children: [
                      LinearProgressIndicator(),
                      CCGap.medium,
                    ],
                  );
                }
                return Container();
              },
            ),

            // google + facebook sign in buttons
            AuthProviderButton.google(),
            CCGap.large,
            AuthProviderButton.facebook(),
          ],
        ),
      ),
    );
  }
}

class AuthProviderButton extends StatelessWidget {
  const AuthProviderButton._({required this.provider});

  factory AuthProviderButton.facebook() => const AuthProviderButton._(
        provider: 'facebook.com',
      );

  factory AuthProviderButton.google() => const AuthProviderButton._(
        provider: 'google.com',
      );

  final String provider;

  @override
  Widget build(BuildContext context) {
    final String? imageAsset;
    final String title;
    final VoidCallback? onPressed;
    switch (provider) {
      case 'facebook.com':
        imageAsset = 'assets/icon/facebook_icon.png';
        title = 'Se connecter avec Facebook'; // TODO : l10n
        onPressed = authenticationCRUD.signInWithFacebook;
      case 'google.com':
        imageAsset = 'assets/icon/google_icon.png';
        title = 'Se connecter avec Google'; // TODO : l10n
        onPressed = authenticationCRUD.signInWithGoogle;
        if (kIsWeb) return authenticationCRUD.webGoogleSignInButton;
      default:
        imageAsset = null;
        title = 'Unable to find provider';
        onPressed = null;
    }
    return ActionChip(
      shape: const RoundedRectangleBorder(
        borderRadius: CCBorderRadiusCircular.xsmall,
        side: BorderSide(
          color: Color.fromARGB(255, 209, 209, 209),
          width: .5,
        ),
      ),
      backgroundColor: Colors.white,
      padding: const EdgeInsets.only(
        left: 12,
        top: 12,
        right: 4,
        bottom: 12,
      ),
      avatar: imageAsset == null
          ? null
          : Image.asset(
              imageAsset,
              height: CCSize.large,
            ),
      label: Text(title, style: const TextStyle(color: Colors.black)),
      onPressed: onPressed,
    );
  }
}
