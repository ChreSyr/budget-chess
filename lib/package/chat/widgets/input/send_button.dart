import 'package:crea_chess/package/chat/widgets/state/inherited_chat_theme.dart';
import 'package:flutter/material.dart';

/// A class that represents send button widget.
class SendButton extends StatelessWidget {
  /// Creates send button widget.
  const SendButton({
    required this.onPressed,
    this.padding = EdgeInsets.zero,
    super.key,
  });

  /// Callback for send button tap event.
  final VoidCallback? onPressed;

  /// Padding around the button.
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) => Container(
        margin: InheritedChatTheme.of(context).theme.sendButtonMargin ??
            const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
        child: Semantics(
          label: 'Send', // TODO : l10n
          child: IconButton(
            constraints: const BoxConstraints(
              minHeight: 24,
              minWidth: 24,
            ),
            icon: InheritedChatTheme.of(context).theme.sendButtonIcon ??
                const Icon(Icons.send),
            onPressed: onPressed,
            padding: padding,
            splashRadius: 24,
            tooltip: 'Send', // TODO : l10n
          ),
        ),
      );
}
