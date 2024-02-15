import 'package:crea_chess/package/atomic_design/dialog/pop_dialog.dart';
import 'package:flutter/material.dart';

void showOkDialog({
  required BuildContext pageContext,
  required String title,
  required Widget content,
}) {
  showDialog<AlertDialog>(
    context: pageContext,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text(title),
        content: content,
        actions: [
          ElevatedButton(
            // for some reason, dialogContext.pop pops the pageContext
            onPressed: () => popDialog(dialogContext),
            child: const Text('Ok'), // TODO : l10n
          ),
        ],
      );
    },
  );
}
