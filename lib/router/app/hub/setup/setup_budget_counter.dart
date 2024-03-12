import 'package:crea_chess/package/atomic_design/modal/modal.dart';
import 'package:crea_chess/package/atomic_design/text_style.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/router/app/hub/setup/role.dart';
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
      onPressed: () => Modal.show(
        context: context,
        title: "Le budget, c'est quoi ?", // TODO : l10n
        sections: [
          const Text(
            // ignore: lines_longer_than_80_chars
            "Chaque partie accorde un budget. Cela signifie que chaque joueur peut disposer ses pièces sur l'échiquier comme bon lui semble, tant que la valeur totale des pièces ne dépasse pas le budget.",
          ),
          CCGap.small,
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('Les valeurs des pièces sont les suivantes :'),
          ),
          CCGap.small,
          ...RoleExt.sortedValues.map(
            (e) => ListTile(
              leading: Icon(e.icon),
              title: Text(
                e.name, // TODO : l10n
                style: CCTextStyle.titleLarge(context),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    e.cost.toString(),
                    style: CCTextStyle.titleLarge(context),
                  ),
                  const Icon(Icons.attach_money),
                ],
              ),
            ),
          ),
        ],
      ),
      icon: const Icon(Icons.attach_money),
      label: Text(
        '$cost / $budget',
        style: CCTextStyle.titleLarge(context),
      ),
    );
  }
}
