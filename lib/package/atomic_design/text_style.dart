import 'package:flutter/material.dart';

extension TextThemeGetter on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension TextStyleExt on TextStyle {
  static const bold = TextStyle(fontWeight: FontWeight.bold);
  static const italic = TextStyle(fontStyle: FontStyle.italic);
}

extension TextThemeExt on TextTheme {
  TextStyle? get infoSmall => bodySmall?.copyWith(
        color: Colors.grey,
        fontWeight: FontWeight.bold,
      );
}
