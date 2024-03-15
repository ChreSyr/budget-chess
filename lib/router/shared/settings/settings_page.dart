import 'package:crea_chess/package/atomic_design/button/filled_circle_button.dart';
import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/atomic_design/dialog/user/delete_account.dart';
import 'package:crea_chess/package/atomic_design/modal/modal.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/text_style.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/l10n/get_locale_flag.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/router/app/app_router.dart';
import 'package:crea_chess/router/app/hub/hub_page.dart';
import 'package:crea_chess/router/shared/ccroute.dart';
import 'package:crea_chess/router/shared/settings/preferences/preferences_cubit.dart';
import 'package:crea_chess/router/shared/settings/preferences/preferences_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SettingsRoute extends CCRoute {
  const SettingsRoute._() : super(name: 'settings', icon: Icons.settings);

  /// Instance
  static const i = SettingsRoute._();

  @override
  String getTitle(AppLocalizations l10n) => l10n.settings;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SettingsPage();
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final preferencesCubit = context.read<PreferencesCubit>();

    return Scaffold(
      appBar: AppBar(title: Text(SettingsRoute.i.getTitle(context.l10n))),
      body: ListView(
        children: [
          CCGap.medium,
          BlocBuilder<PreferencesCubit, PreferencesState>(
            builder: (context, preferences) {
              const buttonSize = CCWidgetSize.small;
              return ExpansionTile(
                title: Text(
                  'Préférences', // TODO : l10n
                  style: context.textTheme.titleLarge,
                ),
                children: [
                  FilledCircleButton.icon(
                    icon:
                        preferences.isDarkMode ? Icons.nightlight : Icons.sunny,
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
          BlocBuilder<AuthNotVerifiedCubit, User?>(
            builder: (context, auth) {
              if (auth == null) return const SizedBox.shrink();

              return ExpansionTile(
                title: Text(
                  'Compte',
                  style: context.textTheme.titleLarge,
                ), // TODO : l10n
                trailing: auth.isVerified
                    ? null
                    : const Icon(Icons.priority_high, color: Colors.red),
                children: [
                  CCGap.large,
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: auth.isVerified
                        ? Text(auth.email ?? '')
                        : Row(
                            children: [
                              Text(auth.email ?? ''),
                              CCGap.small,
                              Text(
                                'non vérifiée', // TODO : l10n
                                style: context.textTheme.bodyMedium?.copyWith(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                    trailing: auth.isVerified
                        ? null
                        : const Icon(Icons.priority_high, color: Colors.red),
                  ),
                  CCGap.large,
                  OutlinedButton.icon(
                    onPressed: () async {
                      await authenticationCRUD.signOut();
                      // We need to send the app router to the root location, so
                      // that the next time the user arrives in this router, he
                      // is properly welcomed.
                      appRouter.goNamed(HubRoute.i.name);
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
      ),
    );
  }
}
