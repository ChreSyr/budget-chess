import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/snack_bar.dart';
import 'package:crea_chess/package/atomic_design/widget/card_button.dart';
import 'package:crea_chess/package/atomic_design/widget/divider.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/firebase/authentication/authentication_crud.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
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
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, User?>(
      listener: (context, user) {
        if (user != null && context.canPop()) context.pop();
      },
      child: const _SignMethodsBody(),
    );
  }
}

class _SignMethodsBody extends StatelessWidget {
  const _SignMethodsBody();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CardButton(
                onTap: authenticationCRUD.signInWithGoogle,
                child: CCPadding.allLarge(
                  child: Image.asset(
                    'assets/icon/google_icon.png',
                    height: CCSize.xxlarge,
                  ),
                ),
              ),
              CCGap.large,
              CardButton(
                onTap: authenticationCRUD.signInWithFacebook,
                child: CCPadding.allLarge(
                  child: Image.asset(
                    'assets/icon/facebook_icon.png',
                    height: CCSize.xxlarge,
                  ),
                ),
              ),
            ],
          ),

          CCGap.large,

          authenticationCRUD.webGoogleSignInButton,

          CCGap.large,
        ],
      ),
    );
  }
}
