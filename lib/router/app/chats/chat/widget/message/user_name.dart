import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/atomic_design/text_style.dart';
import 'package:crea_chess/router/app/chats/chat/widget/state/inherited_user.dart';
import 'package:flutter/material.dart';

/// Renders user's name as a message heading according to the theme.
class UserName extends StatelessWidget {
  /// Creates user name.
  const UserName({
    required this.authorId,
    super.key,
  });

  /// Author to show name from.
  final String? authorId;

  @override
  Widget build(BuildContext context) {
    final chatPartner = InheritedUser.of(context).user;
    if (chatPartner.id != authorId) throw UnimplementedError();
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        chatPartner.username,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: context.textTheme.bodySmall?.copyWith(
          color: context.colorScheme.tertiary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
