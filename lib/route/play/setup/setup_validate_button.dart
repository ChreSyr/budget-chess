import 'package:flutter/material.dart';

class SetupValidateButton extends StatelessWidget {
  const SetupValidateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      icon: const Icon(Icons.check),
      label: const Text('Valider'), // TODO : l10n
      onPressed: () {}, // TODO
    );
  }
}
