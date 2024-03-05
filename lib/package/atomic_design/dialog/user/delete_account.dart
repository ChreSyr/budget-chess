import 'package:crea_chess/package/atomic_design/dialog/pop_dialog.dart';
import 'package:crea_chess/package/atomic_design/snack_bar.dart';
import 'package:crea_chess/package/firebase/authentication/authentication_crud.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<AlertDialog?> showDeleteAccountDialog(
  BuildContext pageContext,
  User user,
) {
  return showDialog<AlertDialog>(
    context: pageContext,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        content: Text(
          pageContext.l10n.deleteAccountExplanation(user.email ?? 'ERROR'),
          // LATER : better message. Toutes les parties jouées
          // et messages envoyés seront définitivement supprimées ?
        ),
        actions: [
          TextButton(
            onPressed: () => popDialog(dialogContext),
            child: Text(pageContext.l10n.cancel),
          ),
          FilledButton(
            child: Text(pageContext.l10n.deleteAccount),
            onPressed: () async {
              try {
                await authenticationCRUD.deleteUserAccount(userId: user.uid);
                // ignore: use_build_context_synchronously
                popDialog(dialogContext);
                // ignore: use_build_context_synchronously
                while (pageContext.canPop()) {
                  // ignore: use_build_context_synchronously
                  pageContext.pop();
                }
              } catch (_) {
                try {
                // ignore: use_build_context_synchronously
                snackBarError(pageContext, pageContext.l10n.errorOccurred);
                } catch (_) {}
              }
            },
          ),
        ],
      );
    },
  );
}
