import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
            onPressed: dialogContext.pop,
            child: const Text('Ok'), // TODO : l10n
          ),
        ],
      );
    },
  );
}
