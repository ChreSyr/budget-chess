import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/text_style.dart';
import 'package:crea_chess/package/chat/models/emoji_enlargement_behavior.dart';
import 'package:crea_chess/package/chat/models/matchers.dart';
import 'package:crea_chess/package/chat/models/pattern_style.dart';
import 'package:crea_chess/package/chat/util.dart';
import 'package:crea_chess/package/chat/widgets/message/user_name.dart';
import 'package:crea_chess/package/chat/widgets/state/inherited_user.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';

/// A class that represents text message widget with optional link preview.
class TextMessage extends StatelessWidget {
  /// Creates a text message widget from a [MessageModel] class.
  const TextMessage({
    required this.emojiEnlargementBehavior,
    required this.hideBackgroundOnEmojiMessages,
    required this.message,
    required this.showName,
    this.nameBuilder,
    this.options = const TextMessageOptions(),
    super.key,
  });

  /// See [Message.emojiEnlargementBehavior].
  final EmojiEnlargementBehavior emojiEnlargementBehavior;

  /// See [Message.hideBackgroundOnEmojiMessages].
  final bool hideBackgroundOnEmojiMessages;

  /// [MessageModel].
  final MessageModel message;

  /// This is to allow custom user name builder
  /// By using this we can fetch newest user info based on id.
  final Widget Function(UserModel)? nameBuilder;

  /// Customisation options for the [TextMessage].
  final TextMessageOptions options;

  /// Show user name for the received message. Useful for a group chat.
  final bool showName;

  Widget _textWidgetBuilder(
    UserModel user,
    BuildContext context,
    bool enlargeEmojis,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showName) UserName(authorId: message.authorId),
        if (enlargeEmojis)
          if (options.isTextSelectable)
            SelectableText(
              message.text ?? '',
              style: const TextStyle(fontSize: 40),
            )
          else
            Text(
              message.text ?? '',
              style: const TextStyle(fontSize: 40),
            )
        else
          TextMessageText(
            text: message.text ?? '',
            options: options,
            bodyTextStyle: context.textTheme.bodyLarge,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final enlargeEmojis =
        emojiEnlargementBehavior != EmojiEnlargementBehavior.never &&
            isConsistsOfEmojis(emojiEnlargementBehavior, message);
    final user = InheritedUser.of(context).user;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: CCSize.medium,
        vertical: CCSize.small,
      ),
      child: _textWidgetBuilder(user, context, enlargeEmojis),
    );
  }
}

/// Widget to reuse the markdown capabilities, e.g., for previews.
class TextMessageText extends StatelessWidget {
  const TextMessageText({
    required this.text,
    this.bodyTextStyle,
    super.key,
    this.maxLines,
    this.options = const TextMessageOptions(),
    this.overflow = TextOverflow.clip,
  });

  /// Regular style to use for any unmatched text. Also used as basis for the
  /// fallback options.
  final TextStyle? bodyTextStyle;

  /// See [ParsedText.maxLines].
  final int? maxLines;

  /// See [TextMessage.options].
  final TextMessageOptions options;

  /// See [ParsedText.overflow].
  final TextOverflow overflow;

  /// Text that is shown as markdown.
  final String text;

  @override
  Widget build(BuildContext context) => ParsedText(
        parse: [
          ...options.matchers,
          boldMatcher(
            style: bodyTextStyle?.merge(PatternStyle.bold.textStyle),
          ),
          italicMatcher(
            style: bodyTextStyle?.merge(PatternStyle.italic.textStyle),
          ),
          lineThroughMatcher(
            style: bodyTextStyle?.merge(PatternStyle.lineThrough.textStyle),
          ),
          codeMatcher(
            style: bodyTextStyle?.merge(PatternStyle.code.textStyle),
          ),
        ],
        maxLines: maxLines,
        overflow: overflow,
        regexOptions: const RegexOptions(multiLine: true, dotAll: true),
        selectable: options.isTextSelectable,
        style: bodyTextStyle,
        text: text,
        textWidthBasis: TextWidthBasis.longestLine,
        alignment: options.alignment,
      );
}

@immutable
class TextMessageOptions {
  const TextMessageOptions({
    this.isTextSelectable = true,
    this.matchers = const [],
    this.alignment = TextAlign.start,
  });

  /// Whether user can tap and hold to select a text content.
  final bool isTextSelectable;

  /// Additional matchers to parse the text.
  final List<MatchText> matchers;

  /// A text alignment property used to align the the text enclosed

  /// Uses a [TextAlign] object and default value is [TextAlign.start]
  final TextAlign alignment;
}
