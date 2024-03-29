import 'package:crea_chess/package/atomic_design/border.dart';
import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/snack_bar.dart';
import 'package:crea_chess/package/atomic_design/text_style.dart';
import 'package:crea_chess/package/atomic_design/widget/divider.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/firebase/authentication/authentication_crud.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/package/preferences/preferences_cubit.dart';
import 'package:crea_chess/package/preferences/preferences_state.dart';
import 'package:crea_chess/route/route_body.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    return CCPadding.allLarge(
      child: SizedBox(
        width: CCWidgetSize.large4,
        child: BlocListener<AuthenticationCubit, User?>(
          listener: (context, user) {
            if (user != null) {
              while (context.canPop()) {
                context.pop();
              }
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(CCSize.xlarge),
                  topRight: Radius.circular(CCSize.xlarge),
                  bottomLeft: Radius.circular(CCSize.xlarge),
                  bottomRight: Radius.circular(CCWidgetSize.xlarge),
                ),
                child: Stack(
                  children: [
                    Image.asset('assets/images/signin.jpg'),
                    CCPadding.allMedium(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome to', // TODO : l10n
                            style: CCTextStyle.displaySmall(context)?.copyWith(
                              color: CCColor.background(context),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Budget Chess', // TODO : l10n
                            style: CCTextStyle.titleLarge(context)?.copyWith(
                              color: CCColor.background(context),
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
    
              // google or facebook loading animation
              const Expanded(child: CCGap.medium),
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
              // CCGap.large,
              // AuthProviderButton.facebook(),

              CCGap.xxxlarge,

              // or continue with
              Row(
                children: [
                  Expanded(child: CCDivider.xthin),
                  CCGap.small,
                  const Text('Ou avec une adresse mail'), // TODO : l10n
                  CCGap.small,
                  Expanded(child: CCDivider.xthin),
                ],
              ),

              // CCGap.xlarge,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // sign in button
                  TextButton(
                    onPressed: () => context.push('/sso/signin'),
                    child: Text(context.l10n.signin),
                  ),
                  CCGap.medium,
                  // sign up button
                  TextButton(
                    onPressed: () => context.push('/sso/signup'),
                    child: Text(context.l10n.signup),
                  ),
                ],
              ),
           
              const Expanded(child: CCGap.medium),
            ],
          ),
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
