import 'package:crea_chess/package/atomic_design/dialog/pop_dialog.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<AlertDialog?> showEmailVerificationDialog(BuildContext pageContext) {
  return showDialog<AlertDialog>(
    context: pageContext,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        content: Text(
          pageContext.l10n.verifyEmailExplanation,
        ),
        actions: [
          TextButton(
            onPressed: () => popDialog(dialogContext),
            child: Text(pageContext.l10n.cancel),
          ),
          FilledButton(
            child: Text(pageContext.l10n.sendEmail),
            onPressed: () {
              popDialog(dialogContext);
              pageContext.push('/sso/email_verification');
            },
          ),
        ],
      );
    },
  );
}
