import 'package:crea_chess/package/atomic_design/dialog/pop_dialog.dart';
import 'package:crea_chess/package/atomic_design/snack_bar.dart';
import 'package:crea_chess/package/firebase/authentication/authentication_crud.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:flutter/material.dart';

Future<AlertDialog?> showResetPasswordDialog(
  BuildContext pageContext,
  String email,
) {
  return showDialog<AlertDialog>(
    context: pageContext,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        content: Text(
          pageContext.l10n.resetPasswordExplanation(email),
        ),
        actions: [
          TextButton(
            onPressed: () => popDialog(dialogContext),
            child: Text(pageContext.l10n.cancel),
          ),
          FilledButton(
            child: Text(pageContext.l10n.sendEmail),
            onPressed: () {
              try {
                authenticationCRUD.sendPasswordResetEmail(email: email);
                snackBarNotify(pageContext, pageContext.l10n.verifyMailbox);
                popDialog(dialogContext);
              } catch (_) {
                snackBarError(pageContext, pageContext.l10n.errorOccurred);
              }
            },
          ),
        ],
      );
    },
  );
}
