import 'package:flutter/material.dart';

abstract class CCTextStyle {
  static const bold = TextStyle(fontWeight: FontWeight.bold);
  static const italic = TextStyle(fontStyle: FontStyle.italic);

  static TextStyle? bodySmall(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall;

  static TextStyle? bodyMedium(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium;

  static TextStyle? bodyLarge(BuildContext context) =>
      Theme.of(context).textTheme.bodyLarge;

  static TextStyle? displaySmall(BuildContext context) =>
      Theme.of(context).textTheme.displaySmall;

  static TextStyle? displayMedium(BuildContext context) =>
      Theme.of(context).textTheme.displayMedium;

  static TextStyle? displayLarge(BuildContext context) =>
      Theme.of(context).textTheme.displayLarge;

  static TextStyle? titleSmall(BuildContext context) =>
      Theme.of(context).textTheme.titleSmall;

  static TextStyle? titleMedium(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium;

  static TextStyle? titleLarge(BuildContext context) =>
      Theme.of(context).textTheme.titleLarge;
}
