import 'package:collection/collection.dart';
import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/atomic_design/dialog/user/delete_account.dart';
import 'package:crea_chess/package/atomic_design/elevation.dart';
import 'package:crea_chess/package/atomic_design/modal/modal.dart';
import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/text_style.dart';
import 'package:crea_chess/package/atomic_design/widget/chip/select_chip.dart';
import 'package:crea_chess/package/atomic_design/widget/feed_card.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_photo.dart';
import 'package:crea_chess/package/chessground/export.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/package/l10n/supported_locale.dart';
import 'package:crea_chess/package/unichess/unichess.dart';
import 'package:crea_chess/router/app/hub/setup/board_settings_cubit.dart';
import 'package:crea_chess/router/app/user/user_page.dart';
import 'package:crea_chess/router/shared/ccroute.dart';
import 'package:crea_chess/router/shared/settings/preferences/preferences_cubit.dart';
import 'package:crea_chess/router/shared/settings/preferences/preferences_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:recase/recase.dart';

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
    final auth = context.watch<AuthNotVerifiedCubit>().state;
    final user = context.watch<UserCubit>().state;

    return Scaffold(
      appBar: AppBar(title: Text(SettingsRoute.i.getTitle(context.l10n))),
      body: SingleChildScrollView(
        child: CCPadding.allLarge(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (auth != null) ...[
                AccountPreviewCard(user),
                CCGap.medium,
              ],
              const PreferencesSettingsCard(),
              if (user.profileCompleted) ...[
                CCGap.medium,
                const BoardSettingsCard(),
              ],
              if (auth != null) ...[
                CCGap.medium,
                AccountSettingsCard(auth),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class AccountPreviewCard extends StatelessWidget {
  const AccountPreviewCard(this.user, {super.key});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    if (!user.profileCompleted) {
      return Card(
        color: context.colorScheme.onInverseSurface,
        elevation: CCElevation.high,
        child: CCPadding.allMedium(
          child: Text(
            context.read<AuthNotVerifiedCubit>().state?.email ?? '',
            style: context.textTheme.bodySmall?.copyWith(color: Colors.grey),
            maxLines: 1,
          ),
        ),
      );
    }

    return Card(
      color: context.colorScheme.onInverseSurface,
      elevation: CCElevation.high,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CCSize.xxxlarge),
      ),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () => UserRoute.pushId(userId: user.id),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '@${user.username}',
                      style: context.textTheme.titleMedium,
                    ),
                    Text(
                      context.read<AuthNotVerifiedCubit>().state?.email ?? '',
                      style: context.textTheme.bodySmall
                          ?.copyWith(color: Colors.grey),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              CCGap.medium,
              const Icon(Icons.edit),
              CCGap.medium,
            ],
          ),
        ),
      ),
    );
  }
}

class PreferencesSettingsCard extends StatelessWidget {
  const PreferencesSettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final preferencesCubit = context.read<PreferencesCubit>();

    return FeedCard(
      title: 'Général', // TODO : l10n
      child: BlocBuilder<PreferencesCubit, PreferencesState>(
        builder: (context, preferences) {
          return Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.fluorescent),
                title: const Text('Dark mode'), // TODO : l10n
                trailing: Switch(
                  value: preferences.isDarkMode,
                  onChanged: (_) => preferencesCubit.toggleTheme(),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.palette),
                title: const Text("Couleur de l'app"), // TODO : l10n
                trailing: FilledButton(
                  child: CCGap.zero,
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
                      CCGap.large,
                    ],
                  ),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.flag),
                title: const Text('Langue'), // TODO : l10n
                trailing: SelectChip<SupportedLocale>.uniqueChoice(
                  values: SupportedLocale.values,
                  selectedValue:
                      SupportedLocale.fromName(context.l10n.localeName),
                  onSelected: (locale) =>
                      preferencesCubit.setLocale(locale.name),
                  valueBuilder: (locale) =>
                      Text('${locale.emoji} ${locale.localized}'),
                  previewBuilder: (locale) =>
                      Text('${locale.emoji} ${locale.localized}'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class BoardSettingsCard extends StatelessWidget {
  const BoardSettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return FeedCard(
      title: 'Board', // TODO : l10n
      child: Column(
        children: _getSections(),
      ),
    );
  }

  static void showAsModal(BuildContext context) => Modal.show(
        context: context,
        title: 'Board settings', // TODO : l10n
        sections: [..._getSections(isModal: true), CCGap.large],
      );

  static List<Widget> _getSections({
    bool isModal = false,
  }) {
    return [
      Builder(
        builder: (context) {
          final boardSettingsCubit = context.watch<BoardSettingsCubit>();
          final boardSettings = boardSettingsCubit.state;

          return Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: SizedBox.square(
                  dimension: CCSize.large,
                  child: BoardWidget(
                    // forces a reload of this widget when the boardTheme
                    // changes
                    key: Key(boardSettings.boardTheme.colors.toString()),
                    data: const BoardData(
                      interactableSide: InteractableSide.none,
                      orientation: Side.white,
                      fen: '2/2',
                    ),
                    size: BoardSize(files: 2, ranks: 2),
                    settings: BoardSettings(
                      boardTheme: boardSettings.boardTheme,
                      enableCoordinates: false,
                    ),
                  ),
                ),
                title: const Text("Thème de l'échiquier"), // TODO : l10n
                subtitle: Text(
                  boardSettings.boardTheme.colors(BoardSize.standard).name,
                ),
                onTap: () {
                  _showBoardThemeModal(context, boardSettingsCubit);
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: PieceWidget(
                  piece: CGPiece.whiteKnight,
                  size: CCSize.large,
                  pieceAssets: boardSettings.pieceSet.assets,
                ),
                title: const Text('Jeu de pièces'), // TODO : l10n
                subtitle: Text(
                  PieceSet.values
                          .firstWhereOrNull(
                            (set) => set == boardSettings.pieceSet,
                          )
                          ?.label ??
                      '',
                ),
                onTap: () {
                  _showPieceSetModal(context, boardSettingsCubit);
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.onetwothree),
                title: const Text('Coordonnées'), // TODO : l10n
                // subtitle: const Text('a-h, 1-8'),
                trailing: Switch(
                  value: boardSettings.enableCoordinates,
                  onChanged: boardSettingsCubit.enableCoordinates,
                ),
              ),
            ],
          );
        },
      ),
    ];
  }

  static void _showBoardThemeModal(
    BuildContext context,
    BoardSettingsCubit cubit,
  ) =>
      Modal.show(
        context: context,
        title: "Thème de l'échiquier",
        sections: [
          Expanded(
            child: ListView(
              children: BoardTheme.values
                  .map(
                    (theme) => Container(
                      // ListTile.color has a strange bug when scrolling
                      color: theme == cubit.state.boardTheme
                          ? context.colorScheme.surfaceVariant
                          : null,
                      child: ListTile(
                        title: BoardWidget(
                          data: const BoardData(
                            interactableSide: InteractableSide.none,
                            orientation: Side.white,
                            fen: '',
                          ),
                          size: BoardSize(files: 8, ranks: 1),
                          settings: BoardSettings(
                            boardTheme: theme,
                            enableCoordinates: false,
                          ),
                        ),
                        subtitle: Text(theme.name.titleCase),
                        onTap: () {
                          Navigator.of(context).pop();
                          cubit.setBoardTheme(theme);
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      );

  static void _showPieceSetModal(
    BuildContext context,
    BoardSettingsCubit cubit,
  ) =>
      Modal.show(
        context: context,
        title: 'Jeu de pièces',
        sections: [
          Expanded(
            child: ListView(
              children: PieceSet.values
                  .map(
                    (set) => Container(
                      // ListTile.color has a strange bug when scrolling
                      color: set == cubit.state.pieceSet
                          ? context.colorScheme.surfaceVariant
                          : null,
                      child: ListTile(
                        title: BoardWidget(
                          data: const BoardData(
                            interactableSide: InteractableSide.none,
                            orientation: Side.white,
                            fen: 'KqRbNp',
                          ),
                          size: BoardSize(files: 6, ranks: 1),
                          settings: BoardSettings(
                            boardTheme: cubit.state.boardTheme,
                            pieceSet: set,
                            enableCoordinates: false,
                          ),
                        ),
                        subtitle: Text(set.label),
                        onTap: () {
                          context.pop();
                          cubit.setPieceSet(set);
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      );
}

class AccountSettingsCard extends StatelessWidget {
  const AccountSettingsCard(this.auth, {super.key});

  final User auth;

  @override
  Widget build(BuildContext context) {
    return FeedCard(
      title: 'Compte', // TODO : l10n
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
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
            contentPadding: EdgeInsets.zero,
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
      ),
    );
  }
}
