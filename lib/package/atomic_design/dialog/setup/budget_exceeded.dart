import 'package:crea_chess/package/atomic_design/dialog/ok_dialog.dart';
import 'package:flutter/material.dart';

void showBudgetExceededDialog({
  required BuildContext pageContext,
  required int budget,
  required int cost,
}) {
  showOkDialog(
    pageContext: pageContext,
    title: 'Budget dépassé !', // TODO : l10n
    content: Text(
      // ignore: lines_longer_than_80_chars
      'Cette partie accorde un budget de $budget, tandis que votre setup coûte $cost. Retirez simplement quelques pièces !',
    ),
  );
}
