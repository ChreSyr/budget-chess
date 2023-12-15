import 'package:crea_chess/package/atomic_design/snack_bar.dart';
import 'package:crea_chess/package/firebase/authentication/authentication_crud.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<AlertDialog?> showResetPasswordDialog(
  BuildContext context,
  String email,
) {
  return showDialog<AlertDialog>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text(
          context.l10n.resetPasswordExplanation(email),
        ),
        actions: [
          TextButton(
            onPressed: context.pop,
            child: Text(context.l10n.cancel),
          ),
          FilledButton(
            child: Text(context.l10n.sendEmail),
            onPressed: () {
              try {
                authenticationCRUD.sendPasswordResetEmail(email: email);
                snackBarNotify(context, context.l10n.verifyMailbox);
                context.pop();
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
