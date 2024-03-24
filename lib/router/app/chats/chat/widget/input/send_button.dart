import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:flutter/material.dart';

/// A class that represents send button widget.
class SendButton extends StatelessWidget {
  /// Creates send button widget.
  const SendButton({
    required this.onPressed,
    super.key,
  });

  /// Callback for send button tap event.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(right: 8),
        child: Semantics(
          label: 'Send', // TODO : l10n
          child: SizedBox(
            height: CCSize.xxlarge,
            width: CCSize.xxlarge,
            child: IconButton.filled(
              icon: const Icon(Icons.send),
              onPressed: onPressed,
              splashRadius: 24,
              tooltip: 'Send', // TODO : l10n
            ),
          ),
        ),
      );
}
