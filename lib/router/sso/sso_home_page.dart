import 'package:crea_chess/package/atomic_design/border.dart';
import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/atomic_design/elevation.dart';
import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/snack_bar.dart';
import 'package:crea_chess/package/atomic_design/text_style.dart';
import 'package:crea_chess/package/atomic_design/widget/divider.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/firebase/authentication/authentication_crud.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/router/shared/app_bar_actions.dart';
import 'package:crea_chess/router/shared/ccroute.dart';
import 'package:crea_chess/router/shared/settings/preferences/preferences_cubit.dart';
import 'package:crea_chess/router/shared/settings/preferences/preferences_state.dart';
import 'package:crea_chess/router/shared/settings/settings_page.dart';
import 'package:crea_chess/router/sso/signin/signin_page.dart';
import 'package:crea_chess/router/sso/signup/signup_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class SSOHomeRoute extends CCRoute {
  const SSOHomeRoute._() : super(name: 'home');

  /// Instance
  static const i = SSOHomeRoute._();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SSOHomePage();

  @override
  List<RouteBase> get routes => [
        SettingsRoute.i.goRoute,
        SignupRoute.i.goRoute,
        SigninRoute.i.goRoute,
      ];
}

class SSOHomePage extends StatelessWidget {
  const SSOHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthNotVerifiedCubit>().state;

    final Widget body;

    // The user is not logged in
    if (auth == null) {
      body = SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: CCWidgetSize.large4,
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 1.1,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(CCWidgetSize.xxxlarge),
                    ),
                    child: Stack(
                      children: [
                        SizedBox.expand(
                          child: Image.asset(
                            'assets/icon/womotaq_icon_v1.png',
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: CCPadding.allMedium(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Welcome to', // TODO : l10n
                                  style: context.textTheme.titleLarge?.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Womotaq',
                                  style:
                                      context.textTheme.displaySmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                CCGap.xxxlarge,
                CCGap.large,

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // sign in button
                    TextButton(
                      onPressed: () => context.pushRoute(SigninRoute.i),
                      child: Text(context.l10n.signin),
                    ),
                    CCGap.medium,
                    // sign up button
                    TextButton(
                      onPressed: () => context.pushRoute(SignupRoute.i),
                      child: Text(context.l10n.signup),
                    ),
                  ],
                ),
                
                CCGap.large,
              ],
            ),
          ),
        ),
      );
    } else

    // The user just asked to delete its account
    if (auth.beingDeleted) {
      body = const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Compte en cours de suppression'),
            CCGap.medium,
            LinearProgressIndicator(),
          ],
        ),
      );
    }

    // The user is logged in, the application will change router
    else {
      body = const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(actions: getSettingsAppBarActions(context)),
      body: body,
      bottomNavigationBar: auth != null
          ? null
          : CCPadding.allMedium(
              child: RichText(
                text: TextSpan(
                  children: [
                    // TODO : l10n
                    const TextSpan(text: 'En continuant, vous acceptez nos '),
                    TextSpan(
                      text: 'Conditions générales d’utilisation',
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        // color: Colors.blue,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => launchUrl(
                              Uri.parse(
                                'https://sites.google.com/womotaq.com/home/terms-of-use',
                              ),
                            ),
                    ),
                    const TextSpan(text: ' et notre '),
                    TextSpan(
                      text: 'Politique de confidentialité',
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        // color: Colors.blue,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => launchUrl(
                              Uri.parse(
                                'https://sites.google.com/womotaq.com/home/privacy-policy',
                              ),
                            ),
                    ),
                    const TextSpan(text: '.'),
                  ],
                ),
                textAlign: TextAlign.center,
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
        final String imageAsset;
        final VoidCallback onPressed;
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
            throw Exception('Unknown provider : $provider');
        }

        return ActionChip(
          shape: const RoundedRectangleBorder(
            borderRadius: CCBorderRadiusCircular.large,
          ),
          side: BorderSide.none,
          backgroundColor: context.colorScheme.surfaceVariant,
          padding: EdgeInsets.zero,
          elevation: CCElevation.medium,
          shadowColor: Colors.black,
          clipBehavior: Clip.hardEdge,
          label: SizedBox(
            width: CCWidgetSize.large2,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: CCSize.large),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(imageAsset, height: CCSize.large),
                        CCGap.medium,
                        Text(
                          context.l10n.signWithProvider(provider),
                          style: context.textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                BlocConsumer<AuthProviderStatusCubit, AuthProviderStatus>(
                  listener: (context, status) {
                    if (status == AuthProviderStatus.error) {
                      snackBarError(context, context.l10n.errorOccurred);
                    }
                  },
                  builder: (context, status) {
                    if (status != AuthProviderStatus.waiting) return CCGap.zero;

                    return const Align(
                      alignment: Alignment.bottomCenter,
                      child: LinearProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
          ),
          onPressed: onPressed,
        );
      },
    );
  }
}
