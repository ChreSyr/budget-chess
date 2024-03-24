import 'package:crea_chess/package/atomic_design/color.dart';
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
        return Image.asset(
          'assets/chat/delivered.png',
          color: context.colorScheme.primary,
        );
      case MessageStatus.sent:
        return Image.asset(
          'assets/chat/delivered.png',
          color: Colors.grey,
        );
      case MessageStatus.error:
        return Image.asset(
          'assets/chat/error.png',
          color: context.colorScheme.error,
        );
      case MessageStatus.seen:
        return Image.asset(
          'assets/chat/seen.png',
          color: context.colorScheme.primary,
        );
      case MessageStatus.sending:
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
      case null:
        return const SizedBox(width: 8);
    }
  }
}
