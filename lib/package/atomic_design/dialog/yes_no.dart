import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:flutter/material.dart';

void showYesNoDialog({
  required BuildContext pageContext,
  required String title,
  required void Function() onYes,
  Widget? content,
}) {
  showDialog<AlertDialog>(
    context: pageContext,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text(title),
        content: content,
        actions: [
          ElevatedButton.icon(
            icon: const Icon(Icons.close),
            // for some reason, dialogContext.pop pops the pageContext
            onPressed: () => Navigator.pop(dialogContext),
            label: Text(pageContext.l10n.no),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.check),
            onPressed: () {
              onYes();
              // for some reason, dialogContext.pop pops the pageContext
              Navigator.pop(dialogContext);
            },
            label: Text(pageContext.l10n.yes),
          ),
        ],
      );
    },
  );
}
