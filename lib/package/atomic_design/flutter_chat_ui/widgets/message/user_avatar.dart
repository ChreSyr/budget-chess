// ignore_for_file: comment_references

import 'package:crea_chess/package/atomic_design/flutter_chat_ui/models/bubble_rtl_alignment.dart';
import 'package:crea_chess/package/atomic_design/flutter_chat_ui/util.dart';
import 'package:crea_chess/package/atomic_design/flutter_chat_ui/widgets/state/inherited_chat_theme.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_model.dart';
import 'package:flutter/material.dart';

/// Renders user's avatar or initials next to a message.
class UserAvatar extends StatelessWidget {
  /// Creates user avatar.
  const UserAvatar({
    required this.author,
    this.bubbleRtlAlignment,
    this.imageHeaders,
    this.onAvatarTap,
    super.key,
  });

  /// Author to show image and name initials from.
  final UserModel author;

  /// See [Message.bubbleRtlAlignment].
  final BubbleRtlAlignment? bubbleRtlAlignment;

  /// See [Chat.imageHeaders].
  final Map<String, String>? imageHeaders;

  /// Called when user taps on an avatar.
  final void Function(UserModel)? onAvatarTap;

  @override
  Widget build(BuildContext context) {
    final color = getUserAvatarNameColor(
      author,
      InheritedChatTheme.of(context).theme.userAvatarNameColors,
    );
    final hasImage = author.photo != null;
    final initials = getUserInitials(author);

    return Container(
      margin: bubbleRtlAlignment == BubbleRtlAlignment.left
          ? const EdgeInsetsDirectional.only(end: 8)
          : const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => onAvatarTap?.call(author),
        child: CircleAvatar(
          backgroundColor: hasImage
              ? InheritedChatTheme.of(context)
                  .theme
                  .userAvatarImageBackgroundColor
              : color,
          backgroundImage: hasImage
              ? NetworkImage(author.photo!, headers: imageHeaders)
              : null,
          radius: 16,
          child: !hasImage
              ? Text(
                  initials,
                  style:
                      InheritedChatTheme.of(context).theme.userAvatarTextStyle,
                )
              : null,
        ),
      ),
    );
  }
}
