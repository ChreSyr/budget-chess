import 'package:crea_chess/package/atomic_design/button/filled_circle_button.dart';
import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/atomic_design/dialog/user/delete_account.dart';
import 'package:crea_chess/package/atomic_design/dialog/user/email_verification.dart';
import 'package:crea_chess/package/atomic_design/modal/modal.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/text_style.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/l10n/get_locale_flag.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/package/preferences/preferences_cubit.dart';
import 'package:crea_chess/package/preferences/preferences_state.dart';
import 'package:crea_chess/route/route_body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SettingsBody extends RouteBody {
  const SettingsBody({super.key});

  static final MainRouteData data = MainRouteData(
    id: 'settings',
    icon: Icons.settings,
    getTitle: (l10n) => l10n.settings,
  );
  static const notifEmailNotVerified = 'email-not-verified';

  @override
  String getTitle(AppLocalizations l10n) {
    return l10n.settings;
  }

  @override
  Widget build(BuildContext context) {
    final preferencesCubit = context.read<PreferencesCubit>();

    return ListView(
      // mainAxisSize: MainAxisSize.min,
      children: [
        CCGap.medium,
        BlocBuilder<PreferencesCubit, PreferencesState>(
          builder: (context, preferences) {
            const buttonSize = CCWidgetSize.small;
            return ExpansionTile(
              title: Text(
                'Préférences', // TODO : l10n
                style: CCTextStyle.titleLarge(context),
              ),
              children: [
                FilledCircleButton.icon(
                  icon: preferences.isDarkMode ? Icons.nightlight : Icons.sunny,
                  onPressed: preferencesCubit.toggleTheme,
                  size: buttonSize,
                ),
                CCGap.large,
                FilledCircleButton.icon(
                  icon: null,
                  onPressed: () => Modal.show(
                    context: context,
                    title: context.l10n.chooseColor,
                    sections: [
                      GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        crossAxisSpacing: CCSize.large,
                        mainAxisSpacing: CCSize.large,
                        children: SeedColor.values
                            .map(
                              (seedColor) => FilledButton(
                                style: TextButton.styleFrom(
                                  minimumSize: Size.zero,
                                  padding: EdgeInsets.zero,
                                  backgroundColor: seedColor.color,
                                ),
                                onPressed: () => context
                                  ..pop()
                                  ..read<PreferencesCubit>()
                                      .setSeedColor(seedColor),
                                child: const Text(''),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                  size: buttonSize,
                ),
                CCGap.large,
                FilledCircleButton.text(
                  text: getLocaleFlag(context.l10n.localeName),
                  onPressed: preferencesCubit.toggleLocale,
                  size: buttonSize,
                ),
              ],
            );
          },
        ),
        BlocBuilder<AuthenticationCubit, User?>(
          builder: (context, auth) {
            if (auth == null) return const SizedBox.shrink();

            return ExpansionTile(
              title: Text(
                'Compte',
                style: CCTextStyle.titleLarge(context),
              ), // TODO : l10n
              trailing: auth.isVerified
                  ? null
                  : const Icon(Icons.priority_high, color: Colors.red),
              children: [
                CCGap.large,
                ListTile(
                  leading: const Icon(Icons.email),
                  title: auth.isVerified
                      ? Text(
                          context.read<AuthenticationCubit>().state?.email ??
                              '',
                        )
                      : Row(
                          children: [
                            Text(
                              context
                                      .read<AuthenticationCubit>()
                                      .state
                                      ?.email ??
                                  '',
                            ),
                            CCGap.small,
                            Text(
                              'non vérifiée', // TODO : l10n
                              style: CCTextStyle.bodyMedium(context)?.copyWith(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                  trailing: auth.isVerified
                      ? null
                      : const Icon(Icons.priority_high, color: Colors.red),
                  onTap: auth.isVerified
                      ? null
                      : () => showEmailVerificationDialog(context),
                ),
                CCGap.large,
                OutlinedButton.icon(
                  onPressed: () {
                    authenticationCRUD.signOut();
                    while (context.canPop()) {
                      context.pop();
                    }
                    context.push('/sso');
                  },
                  icon: const Icon(Icons.logout),
                  label: Text(context.l10n.signout),
                ),
                CCGap.large,
                OutlinedButton.icon(
                  onPressed: () => showDeleteAccountDialog(context, auth),
                  icon: const Icon(Icons.delete_forever),
                  label: Text(context.l10n.deleteAccount),
                  style: ButtonStyle(
                    iconColor: MaterialStateColor.resolveWith(
                      (states) => Colors.red,
                    ),
                    foregroundColor: MaterialStateColor.resolveWith(
                      (states) => Colors.red,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
