import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:flutter/material.dart';

void showEnumChoiceDialog<T extends Enum>(
  BuildContext pageContext, {
  required List<T> choices,
  required T selectedItem,
  required Widget Function(T choice) labelBuilder,
  required void Function(T choice) onSelectedItemChanged,
}) {
  showDialog<void>(
    context: pageContext,
    builder: (dialogContext) {
      return AlertDialog(
        contentPadding: const EdgeInsets.only(top: 12),
        scrollable: true,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: choices.map((value) {
            return RadioListTile<T>(
              title: labelBuilder(value),
              value: value,
              groupValue: selectedItem,
              onChanged: (value) {
                if (value != null) onSelectedItemChanged(value);
                // for some reason, dialogContext.pop pops the pageContext
                Navigator.pop(dialogContext);
              },
            );
          }).toList(growable: false),
        ),
        actions: [
          TextButton(
            // for some reason, dialogContext.pop pops the pageContext
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(pageContext.l10n.cancel),
          ),
        ],
      );
    },
  );
}
