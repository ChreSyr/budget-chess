import 'package:crea_chess/package/atomic_design/dialog/pop_dialog.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:flutter/material.dart';

void showYesNoDialog({
  required BuildContext pageContext,
  required String title,
  required Widget content,
  required void Function() onYes,
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
            onPressed: () => popDialog(dialogContext),
            label: Text(pageContext.l10n.no),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.check),
            onPressed: () {
              onYes();
              // for some reason, dialogContext.pop pops the pageContext
              popDialog(dialogContext);
            },
            label: Text(pageContext.l10n.yes),
          ),
        ],
      );
    },
  );
}
