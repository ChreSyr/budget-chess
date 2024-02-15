import 'package:crea_chess/package/atomic_design/text_style.dart';
import 'package:flutter/material.dart';

class SetupBudgetCounter extends StatelessWidget {
  const SetupBudgetCounter({required this.budgetLeft, super.key});

  final int budgetLeft;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {}, // TODO : dialog or modal explaining budget
      icon: const Icon(Icons.attach_money),
      label: Text(
        budgetLeft.toString(),
        style: CCTextStyle.titleLarge(context),
      ),
    );
  }
}
