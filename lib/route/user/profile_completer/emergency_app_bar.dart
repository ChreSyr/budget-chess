import 'package:crea_chess/package/atomic_design/dialog/user/delete_account.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

enum _MenuChoices {
  signin(whenLoggedOut: true),
  signout(whenLoggedOut: false),
  deleteAccount(whenLoggedOut: false);

  const _MenuChoices({required this.whenLoggedOut});

  final bool whenLoggedOut;

  String getLocalization(AppLocalizations l10n) {
    switch (this) {
      case _MenuChoices.signin:
        return l10n.signin;
      case _MenuChoices.signout:
        return l10n.signout;
      case _MenuChoices.deleteAccount:
        return l10n.deleteAccount;
    }
  }

  IconData getIcon() {
    switch (this) {
      case _MenuChoices.signin:
        return Icons.login;
      case _MenuChoices.signout:
        return Icons.logout;
      case _MenuChoices.deleteAccount:
        return Icons.delete_forever;
    }
  }
}

AppBar getEmergencyAppBar(BuildContext context) => AppBar(
      actions: [
        BlocBuilder<AuthenticationCubit, User?>(
          builder: (context, auth) {
            final isLoggedOut = auth == null;
            void signout() {
              authenticationCRUD.signOut();
              context
                ..go('/user')
                ..push('/sso');
            }

            return MenuAnchor(
              builder: (
                BuildContext context,
                MenuController controller,
                Widget? _,
              ) {
                return IconButton(
                  onPressed: () => controller.isOpen
                      ? controller.close()
                      : controller.open(),
                  icon: const Icon(Icons.more_vert),
                );
              },
              menuChildren: _MenuChoices.values
                  .where((e) => isLoggedOut == e.whenLoggedOut)
                  .map(
                    (e) => MenuItemButton(
                      leadingIcon: Icon(e.getIcon()),
                      onPressed: () {
                        switch (e) {
                          case _MenuChoices.signin:
                            context.push('/sso');
                          case _MenuChoices.signout:
                            signout();
                          case _MenuChoices.deleteAccount:
                            showDeleteAccountDialog(context, auth!);
                        }
                      },
                      style: switch (e) {
                        _MenuChoices.deleteAccount => ButtonStyle(
                            iconColor: MaterialStateColor.resolveWith(
                              (states) => Colors.red,
                            ),
                            foregroundColor: MaterialStateColor.resolveWith(
                              (states) => Colors.red,
                            ),
                          ),
                        _ => null,
                      },
                      child: Text(e.getLocalization(context.l10n)),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ],
    );
