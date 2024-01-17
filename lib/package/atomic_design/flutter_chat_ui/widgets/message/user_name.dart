import 'package:crea_chess/package/atomic_design/flutter_chat_ui/util.dart';
import 'package:crea_chess/package/atomic_design/flutter_chat_ui/widgets/state/inherited_chat_theme.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_model.dart';
import 'package:flutter/material.dart';

/// Renders user's name as a message heading according to the theme.
class UserName extends StatelessWidget {
  /// Creates user name.
  const UserName({
    required this.author,
    super.key,
  });

  /// Author to show name from.
  final UserModel author;

  @override
  Widget build(BuildContext context) {
    final theme = InheritedChatTheme.of(context).theme;
    final color = getUserAvatarNameColor(author, theme.userAvatarNameColors);
    final name = author.username ?? '';

    return name.isEmpty
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.userNameTextStyle.copyWith(color: color),
            ),
          );
  }
}
