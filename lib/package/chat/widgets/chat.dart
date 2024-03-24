import 'dart:math';

import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/text_style.dart';
import 'package:crea_chess/package/chat/models/bubble_rtl_alignment.dart';
import 'package:crea_chess/package/chat/models/date_header.dart';
import 'package:crea_chess/package/chat/models/emoji_enlargement_behavior.dart';
import 'package:crea_chess/package/chat/models/message_spacer.dart';
import 'package:crea_chess/package/chat/models/unread_header_data.dart';
import 'package:crea_chess/package/chat/util.dart';
import 'package:crea_chess/package/chat/widgets/chat_list.dart';
import 'package:crea_chess/package/chat/widgets/input/input.dart';
import 'package:crea_chess/package/chat/widgets/message/message_widget.dart';
import 'package:crea_chess/package/chat/widgets/message/system_message.dart';
import 'package:crea_chess/package/chat/widgets/message/text_message.dart';
import 'package:crea_chess/package/chat/widgets/state/inherited_user.dart';
import 'package:crea_chess/package/chat/widgets/typing_indicator.dart';
import 'package:crea_chess/package/chat/widgets/unread_header.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

/// Keep track of all the auto scroll indices by their respective message's id
/// to allow animating to them.
final Map<String, int> chatMessageAutoScrollIndexById = {};

/// Entry widget, represents the complete chat. If you wrap it in [SafeArea] and
/// it should be full screen, set [SafeArea]'s `bottom` to `false`.
class Chat extends StatefulWidget {
  /// Creates a chat widget.
  const Chat({
    required this.messages,
    required this.onSendPressed,
    required this.user,
    this.bubbleBuilder,
    this.bubbleRtlAlignment = BubbleRtlAlignment.right,
    this.dateFormat,
    this.dateHeaderBuilder,
    this.dateHeaderThreshold = 900000,
    this.dateIsUtc = false,
    this.dateLocale,
    this.emojiEnlargementBehavior = EmojiEnlargementBehavior.multi,
    this.emptyState,
    this.groupMessagesThreshold = 60000,
    this.hideBackgroundOnEmojiMessages = true,
    this.inputOptions = const InputOptions(),
    this.isLastPage,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.listBottomWidget,
    this.nameBuilder,
    this.onBackgroundTap,
    this.onEndReached,
    this.onEndReachedThreshold,
    this.onMessageDoubleTap,
    this.onMessageLongPress,
    this.onMessageStatusLongPress,
    this.onMessageStatusTap,
    this.onMessageTap,
    this.onMessageVisibilityChanged,
    this.scrollController,
    this.scrollPhysics,
    this.scrollToUnreadOptions = const ScrollToUnreadOptions(),
    this.showUserAvatars = false,
    this.showUserNames = false,
    this.textMessageOptions = const TextMessageOptions(),
    this.timeFormat,
    this.typingIndicatorOptions = const TypingIndicatorOptions(),
    this.useTopSafeAreaInset,
    super.key,
  });

  // See [Message.bubbleBuilder].
  final Widget Function(
    Widget child, {
    required MessageModel message,
    required bool nextMessageInGroup,
  })? bubbleBuilder;

  // See [Message.bubbleRtlAlignment].
  final BubbleRtlAlignment? bubbleRtlAlignment;

  /// Allows you to customize the date format. IMPORTANT: only for the date, do
  /// not return time here. See [timeFormat] to customize the time format.
  /// [dateLocale] will be ignored if you use this, so if you want a localized
  /// date make sure you initialize your [DateFormat] with a locale.
  /// See [customDateHeaderText] for more customization.
  final DateFormat? dateFormat;

  /// Custom date header builder gives ability to customize date header widget.
  final Widget Function(DateHeader)? dateHeaderBuilder;

  /// Time (in ms) between two messages when we will render a date header.
  /// Default value is 15 minutes, 900000 ms. When time between two messages
  /// is higher than this threshold, date header will be rendered. Also,
  /// not related to this value, date header will be rendered on every new day.
  final int dateHeaderThreshold;

  /// Use utc time to convert message milliseconds to date.
  final bool dateIsUtc;

  /// Locale will be passed to the `Intl` package. Make sure you initialized
  /// date formatting in your app before passing any locale here, otherwise
  /// an error will be thrown. Also see [customDateHeaderText], [dateFormat],
  /// [timeFormat].
  final String? dateLocale;

  // See [Message.emojiEnlargementBehavior].
  final EmojiEnlargementBehavior emojiEnlargementBehavior;

  /// Allows you to change what the user sees when there are no messages.
  final Widget? emptyState;

  /// Time (in ms) between two messages when we will visually group them.
  /// Default value is 1 minute, 60000 ms. When time between two messages
  /// is lower than this threshold, they will be visually grouped.
  final int groupMessagesThreshold;

  // See [Message.hideBackgroundOnEmojiMessages].
  final bool hideBackgroundOnEmojiMessages;

  /// See [Input.options].
  final InputOptions inputOptions;

  /// See [ChatList.isLastPage].
  final bool? isLastPage;

  /// See [ChatList.keyboardDismissBehavior].
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  /// See [ChatList.bottomWidget]. For a custom chat input
  /// use [customBottomWidget] instead.
  final Widget? listBottomWidget;

  /// List of [MessageModel] to render in the chat widget.
  final List<MessageModel> messages;

  // See [Message.nameBuilder].
  final Widget Function(UserModel)? nameBuilder;

  /// Called when user taps on background.
  final VoidCallback? onBackgroundTap;

  /// See [ChatList.onEndReached].
  final Future<void> Function()? onEndReached;

  /// See [ChatList.onEndReachedThreshold].
  final double? onEndReachedThreshold;

  // See [Message.onMessageDoubleTap].
  final void Function(BuildContext context, MessageModel)? onMessageDoubleTap;

  // See [Message.onMessageLongPress].
  final void Function(BuildContext context, MessageModel)? onMessageLongPress;

  // See [Message.onMessageStatusLongPress].
  final void Function(BuildContext context, MessageModel)?
      onMessageStatusLongPress;

  // See [Message.onMessageStatusTap].
  final void Function(BuildContext context, MessageModel)? onMessageStatusTap;

  // See [Message.onMessageTap].
  final void Function(BuildContext context, MessageModel)? onMessageTap;

  // See [Message.onMessageVisibilityChanged].
  // ignore: avoid_positional_boolean_parameters
  final void Function(MessageModel, bool visible)? onMessageVisibilityChanged;

  /// See [Input.onSendPressed].
  final void Function(String) onSendPressed;

  /// See [ChatList.scrollController].
  /// If provided, you cannot use the scroll to message functionality.
  final AutoScrollController? scrollController;

  /// See [ChatList.scrollPhysics].
  final ScrollPhysics? scrollPhysics;

  /// Controls if and how the chat should scroll to the newest unread message.
  final ScrollToUnreadOptions scrollToUnreadOptions;

  // See [Message.showUserAvatars].
  final bool showUserAvatars;

  /// Show user names for received messages. Useful for a group chat. Will be
  /// shown only on text messages.
  final bool showUserNames;

  // See [Message.textMessageOptions].
  final TextMessageOptions textMessageOptions;

  /// Allows you to customize the time format. IMPORTANT: only for the time, do
  /// not return date here. See [dateFormat] to customize the date format.
  /// [dateLocale] will be ignored if you use this, so if you want a localized
  /// time make sure you initialize your [DateFormat] with a locale.
  /// See [customDateHeaderText] for more customization.
  final DateFormat? timeFormat;

  /// Used to show typing users with indicator. See [TypingIndicatorOptions].
  final TypingIndicatorOptions typingIndicatorOptions;

  /// See [InheritedUser.user].
  final UserModel user;

  /// See [ChatList.useTopSafeAreaInset].
  final bool? useTopSafeAreaInset;

  @override
  State<Chat> createState() => ChatState();
}

/// [Chat] widget state.
class ChatState extends State<Chat> {
  /// Used to get the correct auto scroll index from
  /// [chatMessageAutoScrollIndexById].
  static const String _unreadHeaderId = 'unread_header_id';

  List<Object> _chatMessages = [];
  bool _hadScrolledToUnreadOnOpen = false;

  late final AutoScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = widget.scrollController ?? AutoScrollController();

    didUpdateWidget(widget);
  }

  /// Scroll to the unread header.
  void scrollToUnreadHeader() {
    final unreadHeaderIndex = chatMessageAutoScrollIndexById[_unreadHeaderId];
    if (unreadHeaderIndex != null) {
      _scrollController.scrollToIndex(
        unreadHeaderIndex,
        duration: widget.scrollToUnreadOptions.scrollDuration,
      );
    }
  }

  /// Scroll to the message with the specified [id].
  Future<void> scrollToMessage(
    String id, {
    Duration? scrollDuration,
    bool withHighlight = false,
    Duration? highlightDuration,
  }) async {
    await _scrollController.scrollToIndex(
      chatMessageAutoScrollIndexById[id]!,
      duration: scrollDuration ?? scrollAnimationDuration,
      preferPosition: AutoScrollPosition.middle,
    );
    if (withHighlight) {
      await _scrollController.highlight(
        chatMessageAutoScrollIndexById[id]!,
        highlightDuration: highlightDuration ?? const Duration(seconds: 3),
      );
    }
  }

  /// Highlight the message with the specified [id].
  void highlightMessage(String id, {Duration? duration}) =>
      _scrollController.highlight(
        chatMessageAutoScrollIndexById[id]!,
        highlightDuration: duration ?? const Duration(seconds: 3),
      );

  Widget _emptyStateBuilder() =>
      widget.emptyState ??
      Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Text(
          'No messages here yet', // TODO : l10n
          style: context.textTheme.infoSmall?.copyWith(fontSize: CCSize.medium),
          textAlign: TextAlign.center,
        ),
      );

  /// Only scroll to first unread if there are messages and it is the first
  /// open.
  void _maybeScrollToFirstUnread() {
    if (widget.scrollToUnreadOptions.scrollOnOpen &&
        _chatMessages.isNotEmpty &&
        !_hadScrolledToUnreadOnOpen) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (mounted) {
          await Future<void>.delayed(widget.scrollToUnreadOptions.scrollDelay);
          scrollToUnreadHeader();
        }
      });
      _hadScrolledToUnreadOnOpen = true;
    }
  }

  /// We need the index for auto scrolling because it will scroll until it
  /// reaches an index higher or equal that what it is scrolling towards.
  /// Index will be null for removed messages. Can just set to -1 for auto
  /// scroll.
  Widget _messageBuilder(
    Object object,
    BoxConstraints constraints,
    int? index,
  ) {
    if (object is DateHeader) {
      return widget.dateHeaderBuilder?.call(object) ??
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(bottom: 32, top: 16),
            child: Text(
              object.text,
              style: context.textTheme.infoSmall,
            ),
          );
    } else if (object is MessageSpacer) {
      return SizedBox(
        height: object.height,
      );
    } else if (object is UnreadHeaderData) {
      return AutoScrollTag(
        controller: _scrollController,
        index: index ?? -1,
        key: const Key('unread_header'),
        child: UnreadHeader(
          marginTop: object.marginTop,
        ),
      );
    } else {
      final map = object as Map<String, Object>;
      final message = map['message']! as MessageModel;

      final Widget messageWidget;

      if (message.authorId == null) {
        messageWidget = SystemMessage(message: message.text ?? '');
      } else {
        final messageWidth =
            widget.showUserAvatars && message.authorId != widget.user.id
                ? min(constraints.maxWidth * 0.72, 440).floor()
                : min(constraints.maxWidth * 0.78, 440).floor();
        messageWidget = MessageWidget(
          bubbleBuilder: widget.bubbleBuilder,
          bubbleRtlAlignment: widget.bubbleRtlAlignment,
          emojiEnlargementBehavior: widget.emojiEnlargementBehavior,
          hideBackgroundOnEmojiMessages: widget.hideBackgroundOnEmojiMessages,
          message: message,
          messageWidth: messageWidth,
          nameBuilder: widget.nameBuilder,
          onMessageDoubleTap: widget.onMessageDoubleTap,
          onMessageLongPress: widget.onMessageLongPress,
          onMessageStatusLongPress: widget.onMessageStatusLongPress,
          onMessageStatusTap: widget.onMessageStatusTap,
          onMessageTap: widget.onMessageTap,
          onMessageVisibilityChanged: widget.onMessageVisibilityChanged,
          roundBorder: map['nextMessageInGroup'] == true,
          showAvatar: map['nextMessageInGroup'] == false,
          showName: map['showName'] == true,
          showUserAvatars: widget.showUserAvatars,
          textMessageOptions: widget.textMessageOptions,
        );
      }

      return AutoScrollTag(
        controller: _scrollController,
        index: index ?? -1,
        key: Key('scroll-${message.id}'),
        child: messageWidget,
      );
    }
  }

  /// Updates the [chatMessageAutoScrollIndexById] mapping with the latest
  /// messages.
  void _refreshAutoScrollMapping() {
    chatMessageAutoScrollIndexById.clear();
    var i = 0;
    for (final object in _chatMessages) {
      if (object is UnreadHeaderData) {
        chatMessageAutoScrollIndexById[_unreadHeaderId] = i;
      } else if (object is Map<String, Object>) {
        final message = object['message']! as MessageModel;
        chatMessageAutoScrollIndexById[message.id] = i;
      }
      i++;
    }
  }

  @override
  void didUpdateWidget(covariant Chat oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.messages.isNotEmpty) {
      _chatMessages = calculateChatMessages(
        widget.messages,
        widget.user,
        dateFormat: widget.dateFormat,
        dateHeaderThreshold: widget.dateHeaderThreshold,
        dateIsUtc: widget.dateIsUtc,
        dateLocale: widget.dateLocale,
        groupMessagesThreshold: widget.groupMessagesThreshold,
        lastReadMessageId: widget.scrollToUnreadOptions.lastReadMessageId,
        showUserNames: widget.showUserNames,
        timeFormat: widget.timeFormat,
      );

      _refreshAutoScrollMapping();
      _maybeScrollToFirstUnread();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => InheritedUser(
        user: widget.user,
        child: Stack(
          children: [
            Column(
              children: [
                Flexible(
                  child: widget.messages.isEmpty
                      ? SizedBox.expand(
                          child: _emptyStateBuilder(),
                        )
                      : GestureDetector(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            widget.onBackgroundTap?.call();
                          },
                          child: LayoutBuilder(
                            builder: (
                              BuildContext context,
                              BoxConstraints constraints,
                            ) =>
                                ChatList(
                              bottomWidget: widget.listBottomWidget,
                              bubbleRtlAlignment: widget.bubbleRtlAlignment!,
                              isLastPage: widget.isLastPage,
                              itemBuilder: (Object item, int? index) =>
                                  _messageBuilder(
                                item,
                                constraints,
                                index,
                              ),
                              items: _chatMessages,
                              keyboardDismissBehavior:
                                  widget.keyboardDismissBehavior,
                              onEndReached: widget.onEndReached,
                              onEndReachedThreshold:
                                  widget.onEndReachedThreshold,
                              scrollController: _scrollController,
                              scrollPhysics: widget.scrollPhysics,
                              typingIndicatorOptions:
                                  widget.typingIndicatorOptions,
                              useTopSafeAreaInset:
                                  widget.useTopSafeAreaInset ?? isMobile,
                            ),
                          ),
                        ),
                ),
                Input(
                  onSendPressed: widget.onSendPressed,
                  options: widget.inputOptions,
                ),
              ],
            ),
          ],
        ),
      );
}
