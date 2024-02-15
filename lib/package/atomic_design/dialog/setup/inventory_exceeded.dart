import 'package:crea_chess/package/atomic_design/dialog/ok_dialog.dart';
import 'package:flutter/material.dart';

void showInventoryExceededDialog({
  required BuildContext pageContext,
}) {
  showOkDialog(
    pageContext: pageContext,
    title: 'Oups !', // TODO : l10n
    content: const Text(
      'Votre inventaire ne contient pas assez de pièces pour produire ce setup. Retirez simplement les pièces en trop !',
    ),
  );
}
