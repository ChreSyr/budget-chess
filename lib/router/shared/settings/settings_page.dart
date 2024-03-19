import 'package:crea_chess/package/atomic_design/button/filled_circle_button.dart';
import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/atomic_design/dialog/user/delete_account.dart';
import 'package:crea_chess/package/atomic_design/modal/modal.dart';
import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/text_style.dart';
import 'package:crea_chess/package/atomic_design/widget/chip/select_chip.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_photo.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/package/l10n/supported_locale.dart';
import 'package:crea_chess/router/app/user/user_page.dart';
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
    return Scaffold(
      appBar: AppBar(title: Text(SettingsRoute.i.getTitle(context.l10n))),
      body: ColoredBox(
        color: context.colorScheme.surfaceVariant,
        child: CCPadding.allLarge(
          child: ListView(
            children: [
              BlocBuilder<UserCubit, UserModel>(
                builder: (context, user) {
                  if (user.id.isEmpty) return CCGap.zero;
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(CCSize.xxxlarge),
                    ),
                    child: CCPadding.allSmall(
                      child: Row(
                        children: [
                          CCGap.small,
                          UserPhoto(
                            photo: user.photo,
                            radius: CCSize.xlarge,
                            onTap: () => UserRoute.pushId(userId: user.id),
                          ),
                          CCGap.medium,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '@${user.username}',
                                style: context.textTheme.titleMedium,
                              ),
                              Text(
                                context
                                        .read<AuthNotVerifiedCubit>()
                                        .state
                                        ?.email ??
                                    '',
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          const Expanded(child: CCGap.medium),
                          IconButton(
                            onPressed: authenticationCRUD.signOut,
                            icon: const Icon(Icons.logout),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              CCGap.medium,
              const Card(
                child: Column(
                  children: [
                    CCGap.medium,
                    PreferencesSettings(),
                    CCGap.medium,
                  ],
                ),
              ),
              CCGap.medium,
              const Card(
                child: Column(
                  children: [
                    CCGap.medium,
                    AccountSettings(),
                    CCGap.medium,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PreferencesSettings extends StatelessWidget {
  const PreferencesSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final preferencesCubit = context.read<PreferencesCubit>();

    return BlocBuilder<PreferencesCubit, PreferencesState>(
      builder: (context, preferences) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CCPadding.horizontalMedium(
              child: Text(
                'Préférences', // TODO : l10n
                style: context.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            CCGap.small,
            ListTile(
              leading: const Icon(Icons.fluorescent),
              title: const Text('Dark mode'), // TODO : l10n
              trailing: Switch(
                value: preferences.isDarkMode,
                onChanged: (_) => preferencesCubit.toggleTheme(),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.palette),
              title: const Text("Couleur de l'app"), // TODO : l10n
              trailing: FilledCircleButton.icon(
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
              ),
            ),
            ListTile(
              leading: const Icon(Icons.flag),
              title: const Text('Langue'), // TODO : l10n
              trailing: SelectChip<SupportedLocale>.uniqueChoice(
                values: SupportedLocale.values,
                selectedValue:
                    SupportedLocale.fromName(context.l10n.localeName),
                onSelected: (locale) => preferencesCubit.setLocale(locale.name),
                valueBuilder: (locale) =>
                    Text('${locale.emoji} ${locale.localized}'),
                previewBuilder: (locale) =>
                    Text('${locale.emoji} ${locale.localized}'),
              ),
            ),
          ],
        );
      },
    );
  }
}

class AccountSettings extends StatelessWidget {
  const AccountSettings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthNotVerifiedCubit, User?>(
      builder: (context, auth) {
        if (auth == null) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CCPadding.horizontalMedium(
              child: Text(
                'Compte', // TODO : l10n
                style: context.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            CCGap.small,
            ListTile(
              leading: const Icon(Icons.meeting_room),
              title: Text(context.l10n.signout),
              trailing: IconButton(
                onPressed: () async {
                  final currentRouter = GoRouter.of(context);
                  await authenticationCRUD.signOut();
                  // We need to send the app router to the root location, so
                  // that the next time the user arrives in this router, he
                  // is properly welcomed.
                  currentRouter.goHome();
                },
                icon: const Icon(Icons.logout),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.warning),
              title: Text(context.l10n.deleteAccount),
              trailing: IconButton(
                onPressed: () => showDeleteAccountDialog(context, auth),
                icon: const Icon(Icons.delete_forever),
                style: ButtonStyle(
                  iconColor: MaterialStateColor.resolveWith(
                    (states) => Colors.red,
                  ),
                  foregroundColor: MaterialStateColor.resolveWith(
                    (states) => Colors.red,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
