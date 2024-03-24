import 'package:crea_chess/package/chat/widgets/state/inherited_chat_theme.dart';
import 'package:crea_chess/package/firebase/firestore/relationship/message/message_model.dart';
import 'package:flutter/material.dart';

/// A class that represents a message status.
class MessageStatusIcon extends StatelessWidget {
  /// Creates a message status widget.
  const MessageStatusIcon({required this.status, super.key});

  /// Status of the message.
  final MessageStatus? status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case MessageStatus.delivered:
      case MessageStatus.sent:
        return InheritedChatTheme.of(context).theme.deliveredIcon != null
            ? InheritedChatTheme.of(context).theme.deliveredIcon!
            : Image.asset(
                'assets/chat/delivered.png',
                color: InheritedChatTheme.of(context).theme.primaryColor,
              );
      case MessageStatus.error:
        return InheritedChatTheme.of(context).theme.errorIcon != null
            ? InheritedChatTheme.of(context).theme.errorIcon!
            : Image.asset(
                'assets/chat/error.png',
                color: InheritedChatTheme.of(context).theme.errorColor,
              );
      case MessageStatus.seen:
        return InheritedChatTheme.of(context).theme.seenIcon != null
            ? InheritedChatTheme.of(context).theme.seenIcon!
            : Image.asset(
                'assets/chat/seen.png',
                color: InheritedChatTheme.of(context).theme.primaryColor,
              );
      case MessageStatus.sending:
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
