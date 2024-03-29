import 'package:crea_chess/package/chat/flutter_chat_types/flutter_chat_types.dart'
    as types;
import 'package:crea_chess/package/chat/flutter_chat_ui/widgets/state/inherited_chat_theme.dart';
import 'package:flutter/material.dart';

/// A class that represents a message status.
class MessageStatusIcon extends StatelessWidget {
  /// Creates a message status widget.
  const MessageStatusIcon({required this.status, super.key});

  /// Status of the message.
  final types.MessageStatus? status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case types.MessageStatus.delivered:
      case types.MessageStatus.sent:
        return InheritedChatTheme.of(context).theme.deliveredIcon != null
            ? InheritedChatTheme.of(context).theme.deliveredIcon!
            : Image.asset(
                'assets/chat/delivered.png',
                color: InheritedChatTheme.of(context).theme.primaryColor,
              );
      case types.MessageStatus.error:
        return InheritedChatTheme.of(context).theme.errorIcon != null
            ? InheritedChatTheme.of(context).theme.errorIcon!
            : Image.asset(
                'assets/chat/error.png',
                color: InheritedChatTheme.of(context).theme.errorColor,
              );
      case types.MessageStatus.seen:
        return InheritedChatTheme.of(context).theme.seenIcon != null
            ? InheritedChatTheme.of(context).theme.seenIcon!
            : Image.asset(
                'assets/chat/seen.png',
                color: InheritedChatTheme.of(context).theme.primaryColor,
              );
      case types.MessageStatus.sending:
        return InheritedChatTheme.of(context).theme.sendingIcon != null
            ? InheritedChatTheme.of(context).theme.sendingIcon!
            : Center(
                child: SizedBox(
                  height: 10,
                  width: 10,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.transparent,
                    strokeWidth: 1.5,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      InheritedChatTheme.of(context).theme.primaryColor,
                    ),
                  ),
                ),
              );
      case null:
        return const SizedBox(width: 8);
    }
  }
}
