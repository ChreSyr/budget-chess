import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PatternStyle {
  PatternStyle(this.from, this.regExp, this.replace, this.textStyle);

  final Pattern from;
  final RegExp regExp;
  final String replace;
  final TextStyle textStyle;

  String get pattern => regExp.pattern;

  // ignore: prefer_constructors_over_static_methods
  static PatternStyle get bold => PatternStyle(
        '*',
        RegExp(r'\*[^\*]+\*'),
        '',
        const TextStyle(fontWeight: FontWeight.bold),
      );

  // ignore: prefer_constructors_over_static_methods
  static PatternStyle get code => PatternStyle(
        '`',
        RegExp('`[^`]+`'),
        '',
        TextStyle(
          fontFamily: defaultTargetPlatform == TargetPlatform.iOS
              ? 'Courier'
              : 'monospace',
        ),
      );

  // ignore: prefer_constructors_over_static_methods
  static PatternStyle get italic => PatternStyle(
        '_',
        RegExp('_[^_]+_'),
        '',
        const TextStyle(fontStyle: FontStyle.italic),
      );

  // ignore: prefer_constructors_over_static_methods
  static PatternStyle get lineThrough => PatternStyle(
        '~',
        RegExp('~[^~]+~'),
        '',
        const TextStyle(decoration: TextDecoration.lineThrough),
      );
}
