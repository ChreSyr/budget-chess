import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_photo.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/router/app/chats/chat/model/bubble_rtl_alignment.dart';
import 'package:crea_chess/router/app/chats/chat/model/emoji_enlargement_behavior.dart';
import 'package:crea_chess/router/app/chats/chat/util.dart';
import 'package:crea_chess/router/app/chats/chat/widget/message/message_status_icon.dart';
import 'package:crea_chess/router/app/chats/chat/widget/message/text_message.dart';
import 'package:crea_chess/router/app/chats/chat/widget/state/inherited_user.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Base widget for all message types in the chat. Renders bubbles around
/// messages and status. Sets maximum width for a message for
/// a nice look on larger screens.
class MessageWidget extends StatelessWidget {
  /// Creates a particular message from any message type.
  const MessageWidget({
    required this.emojiEnlargementBehavior,
    required this.hideBackgroundOnEmojiMessages,
    required this.message,
    required this.messageWidth,
    required this.roundBorder,
    required this.showAvatar,
    required this.showName,
    required this.showUserAvatars,
    required this.textMessageOptions,
    super.key,
    this.bubbleBuilder,
    this.bubbleRtlAlignment,
    this.nameBuilder,
    this.onMessageDoubleTap,
    this.onMessageLongPress,
    this.onMessageStatusLongPress,
    this.onMessageStatusTap,
    this.onMessageTap,
    this.onMessageVisibilityChanged,
  });

  /// Customize the default bubble using this function. `child` is a content
  /// you should render inside your bubble, `message` is a current message
  /// (contains `author` inside) and `nextMessageInGroup` allows you to see
  /// if the message is a part of a group (messages are grouped when written
  /// in quick succession by the same author).
  final Widget Function(
    Widget child, {
    required MessageModel message,
    required bool nextMessageInGroup,
  })? bubbleBuilder;

  /// Determine the alignment of the bubble for RTL languages. Has no effect
  /// for the LTR languages.
  final BubbleRtlAlignment? bubbleRtlAlignment;

  /// Controls the enlargement behavior of the emojis in the
  /// [types.TextMessage].
  /// Defaults to [EmojiEnlargementBehavior.multi].
  final EmojiEnlargementBehavior emojiEnlargementBehavior;

  /// Hide background for messages containing only emojis.
  final bool hideBackgroundOnEmojiMessages;

  /// Any message type.
  final MessageModel message;

  /// Maximum message width.
  final int messageWidth;

  /// See [TextMessage.nameBuilder].
  final Widget Function(UserModel)? nameBuilder;

  /// Called when user double taps on any message.
  final void Function(BuildContext context, MessageModel)? onMessageDoubleTap;

  /// Called when user makes a long press on any message.
  final void Function(BuildContext context, MessageModel)? onMessageLongPress;

  /// Called when user makes a long press on status icon in any message.
  final void Function(BuildContext context, MessageModel)?
      onMessageStatusLongPress;

  /// Called when user taps on status icon in any message.
  final void Function(BuildContext context, MessageModel)? onMessageStatusTap;

  /// Called when user taps on any message.
  final void Function(BuildContext context, MessageModel)? onMessageTap;

  /// Called when the message's visibility changes.
  // ignore: avoid_positional_boolean_parameters
  final void Function(MessageModel, bool visible)? onMessageVisibilityChanged;

  /// Rounds border of the message to visually group messages together.
  final bool roundBorder;

  /// Show user avatar for the received message. Useful for a group chat.
  final bool showAvatar;

  /// See [TextMessage.showName].
  final bool showName;

  /// Show user avatars for received messages. Useful for a group chat.
  final bool showUserAvatars;

  /// See [TextMessage.options].
  final TextMessageOptions textMessageOptions;

  Widget _avatarBuilder() => showAvatar
      ? Container(
          margin: bubbleRtlAlignment == BubbleRtlAlignment.left
              ? const EdgeInsetsDirectional.only(end: 8)
              : const EdgeInsets.only(right: 8),
          child: UserPhoto.fromId(
            userId: message.authorId ?? '',
          ),
        )
      : const SizedBox(width: 40);

  Widget _bubbleBuilder(
    BuildContext context,
    BorderRadius borderRadius,
    bool currentUserIsAuthor,
    bool enlargeEmojis,
  ) =>
      bubbleBuilder != null
          ? bubbleBuilder!(
              _messageBuilder(),
              message: message,
              nextMessageInGroup: roundBorder,
            )
          : enlargeEmojis && hideBackgroundOnEmojiMessages
              ? _messageBuilder()
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: borderRadius,
                    color: currentUserIsAuthor
                        ? context.colorScheme.inversePrimary
                        : context.colorScheme.primaryContainer,
                  ),
                  child: ClipRRect(
                    borderRadius: borderRadius,
                    child: _messageBuilder(),
                  ),
                );

  Widget _messageBuilder() {
    return TextMessage(
      emojiEnlargementBehavior: emojiEnlargementBehavior,
      hideBackgroundOnEmojiMessages: hideBackgroundOnEmojiMessages,
      message: message,
      nameBuilder: nameBuilder,
      options: textMessageOptions,
      showName: showName,
    );
  }

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    final user = InheritedUser.of(context).user;
    final currentUserIsAuthor = user.id == message.authorId;
    final enlargeEmojis =
        emojiEnlargementBehavior != EmojiEnlargementBehavior.never &&
            isConsistsOfEmojis(emojiEnlargementBehavior, message);
    const messageBorderRadius = CCSize.medium;
    final borderRadius = bubbleRtlAlignment == BubbleRtlAlignment.left
        ? BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(
              !currentUserIsAuthor || roundBorder ? messageBorderRadius : 0,
            ),
            bottomStart: Radius.circular(
              currentUserIsAuthor || roundBorder ? messageBorderRadius : 0,
            ),
            topEnd: const Radius.circular(messageBorderRadius),
            topStart: const Radius.circular(messageBorderRadius),
          )
        : BorderRadius.only(
            bottomLeft: Radius.circular(
              currentUserIsAuthor || roundBorder ? messageBorderRadius : 0,
            ),
            bottomRight: Radius.circular(
              !currentUserIsAuthor || roundBorder ? messageBorderRadius : 0,
            ),
            topLeft: const Radius.circular(messageBorderRadius),
            topRight: const Radius.circular(messageBorderRadius),
          );

    return Container(
      alignment: bubbleRtlAlignment == BubbleRtlAlignment.left
          ? currentUserIsAuthor
              ? AlignmentDirectional.centerEnd
              : AlignmentDirectional.centerStart
          : currentUserIsAuthor
              ? Alignment.centerRight
              : Alignment.centerLeft,
      margin: bubbleRtlAlignment == BubbleRtlAlignment.left
          ? EdgeInsetsDirectional.only(
              bottom: 4,
              end: isMobile ? query.padding.right : 0,
              start: 20 + (isMobile ? query.padding.left : 0),
            )
          : EdgeInsets.only(
              bottom: 4,
              left: 20 + (isMobile ? query.padding.left : 0),
              right: isMobile ? query.padding.right : 0,
            ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        textDirection: bubbleRtlAlignment == BubbleRtlAlignment.left
            ? null
            : TextDirection.ltr,
        children: [
          if (!currentUserIsAuthor && showUserAvatars) _avatarBuilder(),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: messageWidth.toDouble(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onDoubleTap: () => onMessageDoubleTap?.call(context, message),
                  onLongPress: () => onMessageLongPress?.call(context, message),
                  onTap: () => onMessageTap?.call(context, message),
                  child: onMessageVisibilityChanged != null
                      ? VisibilityDetector(
                          key: Key(message.id),
                          onVisibilityChanged: (visibilityInfo) =>
                              onMessageVisibilityChanged!(
                            message,
                            visibilityInfo.visibleFraction > 0.1,
                          ),
                          child: _bubbleBuilder(
                            context,
                            borderRadius.resolve(Directionality.of(context)),
                            currentUserIsAuthor,
                            enlargeEmojis,
                          ),
                        )
                      : _bubbleBuilder(
                          context,
                          borderRadius.resolve(Directionality.of(context)),
                          currentUserIsAuthor,
                          enlargeEmojis,
                        ),
                ),
              ],
            ),
          ),
          if (currentUserIsAuthor)
            CCPadding.allXsmall(
              child: GestureDetector(
                onLongPress: () =>
                    onMessageStatusLongPress?.call(context, message),
                onTap: () => onMessageStatusTap?.call(context, message),
                child: MessageStatusIcon(status: message.status),
              ),
            ),
        ],
      ),
    );
  }
}
