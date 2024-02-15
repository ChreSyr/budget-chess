import 'package:flutter/material.dart';

class CCColor {
  static Color background(BuildContext context) =>
      Theme.of(context).colorScheme.background;

  static Color cardBorder(BuildContext context) =>
      Theme.of(context).colorScheme.brightness == Brightness.light
          ? Colors.black
          : Colors.grey;

  static Color error(BuildContext context) =>
      Theme.of(context).colorScheme.error;

  static Color inverseSurface(BuildContext context) =>
      Theme.of(context).colorScheme.inverseSurface;

  static Color onBackground(BuildContext context) =>
      Theme.of(context).colorScheme.onBackground;

  static Color onError(BuildContext context) =>
      Theme.of(context).colorScheme.onError;

  static Color onInverseSurface(BuildContext context) =>
      Theme.of(context).colorScheme.onInverseSurface;

  static Color onPrimaryContainer(BuildContext context) =>
      Theme.of(context).colorScheme.onPrimaryContainer;

  static Color onSecondary(BuildContext context) =>
      Theme.of(context).colorScheme.onSecondary;

  static Color onSurfaceVariant(BuildContext context) =>
      Theme.of(context).colorScheme.onSurfaceVariant;

  static Color outline(BuildContext context) =>
      Theme.of(context).colorScheme.outline;

  static Color primary(BuildContext context) =>
      Theme.of(context).colorScheme.primary;

  static Color primaryContainer(BuildContext context) =>
      Theme.of(context).colorScheme.primaryContainer;

  static Color secondaryContainer(BuildContext context) =>
      Theme.of(context).colorScheme.secondaryContainer;

  // TODO : check
  static Color surfaceTintColor(BuildContext context) =>
      CardTheme.of(context).surfaceTintColor ??
      Theme.of(context).colorScheme.error;

  static Color surfaceVariant(BuildContext context) =>
      Theme.of(context).colorScheme.surfaceVariant;
  
  static Color transparentGrey = const Color.fromARGB(128, 0, 0, 0);
}

enum SeedColor {
  lightgreen(Color.fromRGBO(131, 174, 131, 1)),
  green(Color.fromRGBO(12, 163, 12, 1)),
  blue(Color.fromRGBO(71, 234, 255, 1)),
  pink(Color.fromRGBO(255, 58, 206, 1)),
  yellow(Color.fromARGB(255, 255, 233, 34)),
  orange(Color.fromARGB(255, 255, 136, 0));

  const SeedColor(this.color);

  final Color color;
}
