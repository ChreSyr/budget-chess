import 'package:crea_chess/package/atomic_design/dialog/ok_dialog.dart';
import 'package:flutter/material.dart';

void showNotOneKingDialog({
  required BuildContext pageContext,
}) {
  showOkDialog(
    pageContext: pageContext,
    title: 'Setup incomplet !', // TODO : l10n
    content: const Text(
      'Il manque un roi dans votre setup.',
    ),
  );
}
