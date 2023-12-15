import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<AlertDialog?> showEmailVerificationDialog(BuildContext context) {
  return showDialog<AlertDialog>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text(
          context.l10n.verifyEmailExplanation,
        ),
        actions: [
          TextButton(
            onPressed: context.pop,
            child: Text(context.l10n.cancel),
          ),
          FilledButton(
            child: Text(context.l10n.sendEmail),
            onPressed: () {
              context
                ..pop()
                ..push('/sso/email_verification');
            },
          ),
        ],
      );
    },
  );
}
