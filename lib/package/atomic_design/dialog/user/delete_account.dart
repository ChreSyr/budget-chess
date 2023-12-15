import 'package:crea_chess/package/atomic_design/snack_bar.dart';
import 'package:crea_chess/package/firebase/authentication/authentication_crud.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<AlertDialog?> showDeleteAccountDialog(BuildContext context, User user) {
  return showDialog<AlertDialog>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text(
          context.l10n.deleteAccountExplanation(user.email ?? 'ERROR'),
          // LATER : better message. Toutes les parties jouées
          // et messages envoyés seront définitivement supprimées ?
        ),
        actions: [
          TextButton(
            onPressed: context.pop,
            child: Text(context.l10n.cancel),
          ),
          FilledButton(
            child: Text(context.l10n.deleteAccount),
            onPressed: () {
              try {
                authenticationCRUD.deleteUserAccount(userId: user.uid);
                snackBarNotify(context, context.l10n.deletedAccount);
                // pop menu
                context.pop();
                // sigout
                authenticationCRUD.signOut();
              } catch (_) {
                snackBarError(context, context.l10n.errorOccurred);
              }
            },
          ),
        ],
      );
    },
  );
}
