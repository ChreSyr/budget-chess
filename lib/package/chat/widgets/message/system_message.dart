import 'package:crea_chess/package/atomic_design/border.dart';
import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/text_style.dart';
import 'package:crea_chess/package/chat/widgets/message/text_message.dart';
import 'package:flutter/material.dart';

/// A class that represents system message widget.
class SystemMessage extends StatelessWidget {
  const SystemMessage({
    required this.message,
    this.options = const TextMessageOptions(alignment: TextAlign.center),
    super.key,
  });

  /// System message.
  final String message;

  /// See [TextMessage.options].
  final TextMessageOptions options;

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(
          bottom: CCSize.large,
          top: CCSize.small,
          left: CCSize.large,
          right: CCSize.large,
        ),
        decoration: BoxDecoration(
          color: context.colorScheme.onInverseSurface,
          borderRadius: CCBorderRadiusCircular.small,
        ),
        child: CCPadding.allSmall(
          child: TextMessageText(
            bodyTextStyle: context.textTheme.infoSmall,
            options: options,
            text: message,
          ),
        ),
      );
}

@immutable
class SystemMessageTheme {
  const SystemMessageTheme({
    required this.margin,
    required this.textStyle,
    this.linkTextStyle,
    this.boldTextStyle,
    this.codeTextStyle,
  });

  /// Margin around the system message.
  final EdgeInsets margin;

  /// Style to apply to anything that matches a link.
  final TextStyle? linkTextStyle;

  /// Regular style to use for any unmatched text. Also used as basis for the
  /// fallback options.
  final TextStyle textStyle;

  /// Style to apply to anything that matches bold markdown.
  final TextStyle? boldTextStyle;

  /// Style to apply to anything that matches code markdown.
  final TextStyle? codeTextStyle;
}
