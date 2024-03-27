import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/firebase/firestore/relationship/message/message_model.dart';
import 'package:flutter/material.dart';

/// A class that represents a message status.
class MessageStatusIcon extends StatelessWidget {
  /// Creates a message status widget.
  const MessageStatusIcon({required this.message, super.key});

  /// The message to show the status of.
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    switch (message.sendStatus) {
      case MessageSendStatus.sending:
        return SizedBox(
          height: 10,
          width: 16,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: CircularProgressIndicator(
              strokeWidth: 1.5,
              valueColor: AlwaysStoppedAnimation<Color>(
                context.colorScheme.primary,
              ),
            ),
          ),
        );
      case MessageSendStatus.error:
        return Image.asset(
          'assets/chat/error.png',
          color: context.colorScheme.error,
        );
      case MessageSendStatus.sent:
        switch (message.globalSeenStatus) {
          case MessageSeenStatus.sentTo:
            return Image.asset(
              'assets/chat/delivered.png',
              color: Colors.grey,
            );
          case MessageSeenStatus.delivered:
            return Image.asset(
              'assets/chat/delivered.png',
              color: context.colorScheme.primary,
            );
          case MessageSeenStatus.seen:
            return Image.asset(
              'assets/chat/seen.png',
              color: context.colorScheme.primary,
            );
        }
      // case null:
      //   return const SizedBox(width: 8);
    }
  }
}
