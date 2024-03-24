import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/atomic_design/text_style.dart';
import 'package:flutter/material.dart';

class UnreadHeader extends StatelessWidget {
  const UnreadHeader({super.key, this.marginTop});

  /// Top margin of the header.
  final double? marginTop;

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.center,
        color: Colors.grey,
        margin: EdgeInsets.only(bottom: 24, top: marginTop ?? 0),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Text(
          'Unread messages', // TODO : l10n
          style: context.textTheme.infoSmall?.copyWith(
            color: context.colorScheme.background,
          ),
          textAlign: TextAlign.center,
        ),
      );
}

@immutable
class ScrollToUnreadOptions {
  const ScrollToUnreadOptions({
    this.lastReadMessageId,
    this.scrollDelay = Duration.zero,
    this.scrollDuration = const Duration(milliseconds: 150),
    this.scrollOnOpen = false,
  });

  /// Will show an unread messages header after this message if there are more
  /// messages to come and will scroll to this header on
  /// [ChatState.scrollToUnreadHeader].
  final String? lastReadMessageId;

  /// Duration to wait after open until the scrolling starts.
  final Duration scrollDelay;

  /// Duration for the animation of the scrolling.
  final Duration scrollDuration;

  /// Whether to scroll to the first unread message on open.
  final bool scrollOnOpen;
}

@immutable
class UnreadHeaderTheme {
  const UnreadHeaderTheme({
    required this.color,
    required this.textStyle,
  });

  /// Background color of the header.
  final Color color;

  /// Text style for the unread message header text.
  final TextStyle textStyle;
}
