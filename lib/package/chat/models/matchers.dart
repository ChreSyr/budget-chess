import 'package:crea_chess/package/chat/models/pattern_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';

MatchText _patternStyleMatcher({
  required PatternStyle patternStyle,
  TextStyle? style,
}) =>
    MatchText(
      pattern: patternStyle.pattern,
      style: style,
      renderText: ({required String str, required String pattern}) => {
        'display': str.replaceAll(
          patternStyle.from,
          patternStyle.replace,
        ),
      },
    );

MatchText boldMatcher({TextStyle? style}) => _patternStyleMatcher(
      patternStyle: PatternStyle.bold,
      style: style,
    );

MatchText italicMatcher({TextStyle? style}) => _patternStyleMatcher(
      patternStyle: PatternStyle.italic,
      style: style,
    );

MatchText lineThroughMatcher({TextStyle? style}) => _patternStyleMatcher(
      patternStyle: PatternStyle.lineThrough,
      style: style,
    );

MatchText codeMatcher({TextStyle? style}) => _patternStyleMatcher(
      patternStyle: PatternStyle.code,
      style: style,
    );
