import 'package:crea_chess/package/atomic_design/border.dart';
import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/snack_bar.dart';
import 'package:crea_chess/package/atomic_design/widget/divider.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/firebase/authentication/authentication_crud.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/package/preferences/preferences_cubit.dart';
import 'package:crea_chess/package/preferences/preferences_state.dart';
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
  List<Widget> getActions(BuildContext context) => [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, User?>(
      listener: (context, user) {
        if (user != null && context.canPop()) context.pop();
      },
      child: SizedBox(
        width: CCWidgetSize.large4,
        child: Column(
          children: [
            SizedBox(
              width: CCWidgetSize.xlarge,
              child: ListView(
                shrinkWrap: true,
                children: [
                  // sign in button
                  FilledButton(
                    onPressed: () => context.push('/sso/signin'),
                    child: Text(context.l10n.signin),
                  ),
                  CCGap.medium,
                  // sign up button
                  FilledButton(
                    onPressed: () => context.push('/sso/signup'),
                    child: Text(context.l10n.signup),
                  ),
                ],
              ),
            ),

            CCGap.xlarge,

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

            // google or facebook loading animation
            CCGap.medium,
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
            CCGap.medium,

            // google + facebook sign in buttons
            AuthProviderButton.google(),
            // CCGap.large,
            // AuthProviderButton.facebook(),
          ],
        ),
      ),
    );
  }
}

class AuthProviderButton extends StatelessWidget {
  const AuthProviderButton._({required this.provider});

  factory AuthProviderButton.facebook() => const AuthProviderButton._(
        provider: 'facebook',
      );

  factory AuthProviderButton.google() => const AuthProviderButton._(
        provider: 'google',
      );

  final String provider;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreferencesCubit, PreferencesState>(
      builder: (context, preferences) {
        final String? imageAsset;
        final VoidCallback? onPressed;
        switch (provider) {
          case 'facebook':
            imageAsset = 'assets/icon/facebook_icon.png';
            onPressed = authenticationCRUD.signInWithFacebook;
          case 'google':
            // LATER : why is this not working ?
            // if (kIsWeb) {
            //   return authenticationCRUD.getGoogleSignInButton(
            //     darkMode: preferences.isDarkMode,
            //   );
            // }
            imageAsset = 'assets/icon/google_icon.png';
            onPressed = authenticationCRUD.signInWithGoogle;
          default:
            imageAsset = null;
            onPressed = null;
        }

        return ActionChip(
          shape: RoundedRectangleBorder(
            borderRadius: CCBorderRadiusCircular.medium,
            side: BorderSide(
              color: CCColor.onBackground(context),
              width: .5,
            ),
          ),
          padding: const EdgeInsets.only(
            left: 24,
            top: 24,
            right: 16,
            bottom: 24,
          ),
          elevation: 5,
          shadowColor: Colors.black,
          avatar: imageAsset == null
              ? null
              : Image.asset(
                  imageAsset,
                  height: CCSize.large,
                ),
          label: Text(context.l10n.signWithProvider(provider)),
          onPressed: onPressed,
        );
      },
    );
  }
}
