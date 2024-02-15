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
      'Cette partie accorde un budget de $budget, tandis que votre setup coûte $cost. Retirez simplement quelques pièces !',
    ),
  );
}
