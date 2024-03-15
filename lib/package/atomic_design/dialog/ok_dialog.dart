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
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Ok'), // TODO : l10n
          ),
        ],
      );
    },
  );
}
