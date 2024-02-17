import 'package:crea_chess/package/chat/flutter_chat_types/flutter_chat_types.dart'
    as types;
import 'package:crea_chess/package/chat/flutter_chat_ui/conditional/conditional.dart';
import 'package:crea_chess/package/chat/flutter_chat_ui/models/bubble_rtl_alignment.dart';
import 'package:crea_chess/package/chat/flutter_chat_ui/models/emoji_enlargement_behavior.dart';
import 'package:crea_chess/package/chat/flutter_chat_ui/util.dart';
import 'package:crea_chess/package/chat/flutter_chat_ui/widgets/message/file_message.dart';
import 'package:crea_chess/package/chat/flutter_chat_ui/widgets/message/image_message.dart';
import 'package:crea_chess/package/chat/flutter_chat_ui/widgets/message/message_status_icon.dart';
import 'package:crea_chess/package/chat/flutter_chat_ui/widgets/message/text_message.dart';
import 'package:crea_chess/package/chat/flutter_chat_ui/widgets/message/user_avatar.dart';
import 'package:crea_chess/package/chat/flutter_chat_ui/widgets/state/inherited_chat_theme.dart';
import 'package:crea_chess/package/chat/flutter_chat_ui/widgets/state/inherited_user.dart';
import 'package:crea_chess/package/chat/message/message_model.dart';
import 'package:crea_chess/package/firebase/export.dart';
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
    required this.showStatus,
    required this.showUserAvatars,
    required this.textMessageOptions,
    required this.usePreviewData,
    super.key,
    this.audioMessageBuilder,
    this.avatarBuilder,
    this.bubbleBuilder,
    this.bubbleRtlAlignment,
    this.customMessageBuilder,
    this.customStatusBuilder,
    this.fileMessageBuilder,
    this.imageHeaders,
    this.imageMessageBuilder,
    this.imageProviderBuilder,
    this.nameBuilder,
    this.onAvatarTap,
    this.onMessageDoubleTap,
    this.onMessageLongPress,
    this.onMessageStatusLongPress,
    this.onMessageStatusTap,
    this.onMessageTap,
    this.onMessageVisibilityChanged,
    this.onPreviewDataFetched,
    this.textMessageBuilder,
    this.userAgent,
    this.videoMessageBuilder,
  });

  /// Build an audio message inside predefined bubble.
  final Widget Function(MessageModel, {required int messageWidth})?
      audioMessageBuilder;

  /// This is to allow custom user avatar builder
  /// By using this we can fetch newest user info based on id.
  final Widget Function(UserModel author)? avatarBuilder;

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

  /// Build a custom message inside predefined bubble.
  final Widget Function(MessageModel, {required int messageWidth})?
      customMessageBuilder;

  /// Build a custom status widgets.
  final Widget Function(MessageModel message, {required BuildContext context})?
      customStatusBuilder;

  /// Controls the enlargement behavior of the emojis in the
  /// [types.TextMessage].
  /// Defaults to [EmojiEnlargementBehavior.multi].
  final EmojiEnlargementBehavior emojiEnlargementBehavior;

  /// Build a file message inside predefined bubble.
  final Widget Function(MessageModel, {required int messageWidth})?
      fileMessageBuilder;

  /// Hide background for messages containing only emojis.
  final bool hideBackgroundOnEmojiMessages;

  /// See [Chat.imageHeaders].
  final Map<String, String>? imageHeaders;

  /// Build an image message inside predefined bubble.
  final Widget Function(MessageModel, {required int messageWidth})?
      imageMessageBuilder;

  /// See [Chat.imageProviderBuilder].
  final ImageProvider Function({
    required String uri,
    required Map<String, String>? imageHeaders,
    required Conditional conditional,
  })? imageProviderBuilder;

  /// Any message type.
  final MessageModel message;

  /// Maximum message width.
  final int messageWidth;

  /// See [TextMessage.nameBuilder].
  final Widget Function(UserModel)? nameBuilder;

  /// See [UserAvatar.onAvatarTap].
  final void Function(UserModel)? onAvatarTap;

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

  /// See [TextMessage.onPreviewDataFetched].
  final void Function(MessageModel, types.PreviewData)? onPreviewDataFetched;

  /// Rounds border of the message to visually group messages together.
  final bool roundBorder;

  /// Show user avatar for the received message. Useful for a group chat.
  final bool showAvatar;

  /// See [TextMessage.showName].
  final bool showName;

  /// Show message's status.
  final bool showStatus;

  /// Show user avatars for received messages. Useful for a group chat.
  final bool showUserAvatars;

  /// Build a text message inside predefined bubble.
  final Widget Function(
    MessageModel, {
    required int messageWidth,
    required bool showName,
  })? textMessageBuilder;

  /// See [TextMessage.options].
  final TextMessageOptions textMessageOptions;

  /// See [TextMessage.usePreviewData].
  final bool usePreviewData;

  /// See [TextMessage.userAgent].
  final String? userAgent;

  /// Build an audio message inside predefined bubble.
  final Widget Function(MessageModel, {required int messageWidth})?
      videoMessageBuilder;

  Widget _avatarBuilder() => const SizedBox(width: 40);
  // Widget _avatarBuilder() => showAvatar
  //     ? avatarBuilder?.call(message.author) ??
  //         UserAvatar(
  //           author: message.author,
  //           bubbleRtlAlignment: bubbleRtlAlignment,
  //           imageHeaders: imageHeaders,
  //           onAvatarTap: onAvatarTap,
  //         )
  //     : const SizedBox(width: 40);

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
                    color: !currentUserIsAuthor ||
                            message.type == types.MessageType.image
                        ? InheritedChatTheme.of(context).theme.secondaryColor
                        : InheritedChatTheme.of(context).theme.primaryColor,
                  ),
                  child: ClipRRect(
                    borderRadius: borderRadius,
                    child: _messageBuilder(),
                  ),
                );

  Widget _messageBuilder() {
    switch (message.type) {
      case types.MessageType.audio:
        final audioMessage = message;
        return audioMessageBuilder != null
            ? audioMessageBuilder!(audioMessage, messageWidth: messageWidth)
            : const SizedBox();
      case types.MessageType.custom:
        final customMessage = message;
        return customMessageBuilder != null
            ? customMessageBuilder!(customMessage, messageWidth: messageWidth)
            : const SizedBox();
      case types.MessageType.file:
        final fileMessage = message;
        return fileMessageBuilder != null
            ? fileMessageBuilder!(fileMessage, messageWidth: messageWidth)
            : FileMessage(message: fileMessage);
      case types.MessageType.image:
        final imageMessage = message;
        return imageMessageBuilder != null
            ? imageMessageBuilder!(imageMessage, messageWidth: messageWidth)
            : ImageMessage(
                imageHeaders: imageHeaders,
                imageProviderBuilder: imageProviderBuilder,
                message: imageMessage,
                messageWidth: messageWidth,
              );
      case types.MessageType.text:
        final textMessage = message;
        return textMessageBuilder != null
            ? textMessageBuilder!(
                textMessage,
                messageWidth: messageWidth,
                showName: showName,
              )
            : TextMessage(
                emojiEnlargementBehavior: emojiEnlargementBehavior,
                hideBackgroundOnEmojiMessages: hideBackgroundOnEmojiMessages,
                message: textMessage,
                nameBuilder: nameBuilder,
                onPreviewDataFetched: onPreviewDataFetched,
                options: textMessageOptions,
                showName: showName,
                usePreviewData: usePreviewData,
                userAgent: userAgent,
              );
      case types.MessageType.video:
        final videoMessage = message;
        return videoMessageBuilder != null
            ? videoMessageBuilder!(videoMessage, messageWidth: messageWidth)
            : const SizedBox();
      case types.MessageType.system:
      case types.MessageType.unsupported:
      case null:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    final user = InheritedUser.of(context).user;
    final currentUserIsAuthor = user.id == message.authorId;
    final enlargeEmojis =
        emojiEnlargementBehavior != EmojiEnlargementBehavior.never &&
            message.type == types.MessageType.text &&
            isConsistsOfEmojis(emojiEnlargementBehavior, message);
    final messageBorderRadius =
        InheritedChatTheme.of(context).theme.messageBorderRadius;
    final borderRadius = bubbleRtlAlignment == BubbleRtlAlignment.left
        ? BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(
              !currentUserIsAuthor || roundBorder ? messageBorderRadius : 0,
            ),
            bottomStart: Radius.circular(
              currentUserIsAuthor || roundBorder ? messageBorderRadius : 0,
            ),
            topEnd: Radius.circular(messageBorderRadius),
            topStart: Radius.circular(messageBorderRadius),
          )
        : BorderRadius.only(
            bottomLeft: Radius.circular(
              currentUserIsAuthor || roundBorder ? messageBorderRadius : 0,
            ),
            bottomRight: Radius.circular(
              !currentUserIsAuthor || roundBorder ? messageBorderRadius : 0,
            ),
            topLeft: Radius.circular(messageBorderRadius),
            topRight: Radius.circular(messageBorderRadius),
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
                          key: Key(message.id ?? ''),
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
            Padding(
              padding: InheritedChatTheme.of(context).theme.statusIconPadding,
              child: showStatus
                  ? GestureDetector(
                      onLongPress: () =>
                          onMessageStatusLongPress?.call(context, message),
                      onTap: () => onMessageStatusTap?.call(context, message),
                      child: customStatusBuilder != null
                          ? customStatusBuilder!(message, context: context)
                          : MessageStatusIcon(status: message.status),
                    )
                  : null,
            ),
        ],
      ),
    );
  }
}
