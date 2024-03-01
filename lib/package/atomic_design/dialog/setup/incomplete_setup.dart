import 'package:crea_chess/package/atomic_design/dialog/yes_no.dart';
import 'package:flutter/material.dart';

void showIncompleteSetupDialog({
  required BuildContext pageContext,
  required VoidCallback onYes,
}) {
  showYesNoDialog(
    pageContext: pageContext,
    title: 'Attention !', // TODO : l10n
    content: const Text(
      // ignore: lines_longer_than_80_chars
      'Il vous reste encore un peu de budget pour placer vos pièces.\n\nVoulez-vous valider ce setup malgré tout ?',
    ),
    onYes: onYes,
  );
}
