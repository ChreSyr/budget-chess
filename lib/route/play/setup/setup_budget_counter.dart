import 'package:crea_chess/package/atomic_design/text_style.dart';
import 'package:flutter/material.dart';

class SetupBudgetCounter extends StatelessWidget {
  const SetupBudgetCounter({
    required this.budget,
    required this.cost,
    super.key,
  });

  final int budget;
  final int cost;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {}, // TODO : dialog or modal explaining budget
      icon: const Icon(Icons.attach_money),
      label: Text(
        '$cost / $budget',
        style: CCTextStyle.titleLarge(context),
      ),
    );
  }
}
