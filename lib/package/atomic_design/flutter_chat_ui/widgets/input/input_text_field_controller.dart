// ignore_for_file: comment_references

import 'package:crea_chess/package/atomic_design/flutter_chat_ui/models/pattern_style.dart';
import 'package:flutter/material.dart';

/// Controller for the [TextField] on [Input] widget
/// To highlighting the matches for pattern.
class InputTextFieldController extends TextEditingController {
  /// A map of style to apply to the text pattern.
  final List<PatternStyle> _listPatternStyle = [
    PatternStyle.bold,
    PatternStyle.italic,
    PatternStyle.lineThrough,
    PatternStyle.code,
  ];

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    required bool withComposing, TextStyle? style,
  }) {
    final children = <TextSpan>[];

    text.splitMapJoin(
      RegExp(_listPatternStyle.map((it) => it.regExp.pattern).join('|')),
      onMatch: (match) {
        final text = match[0]!;
        final style = _listPatternStyle
            .firstWhere((element) => element.regExp.hasMatch(text))
            .textStyle;

        final span = TextSpan(text: match.group(0), style: style);
        children.add(span);
        return span.toPlainText();
      },
      onNonMatch: (text) {
        final span = TextSpan(text: text, style: style);
        children.add(span);
        return span.toPlainText();
      },
    );

    return TextSpan(style: style, children: children);
  }
}
