import 'package:crea_chess/package/atomic_design/dialog/ok_dialog.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showBudgetExceededDialog({
  required BuildContext pageContext,
  required int budget,
  required int cost,
}) {
  final currentUserId = pageContext.read<UserCubit>().state?.id;
  if (currentUserId == null) return; // should never happen

  showOkDialog(
    pageContext: pageContext,
    title: 'Budget dépassé !', // TODO : l10n
    content: Text(
      'Cette partie accorde un budget de $budget, tandis que votre setup coûte $cost.\nRetirez simplement quelques pièces.',
    ),
  );
}
