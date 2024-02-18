import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:flutter/widgets.dart';

abstract class AccountPref<T> {
  T get value;
  String get toFormData;
}

class BooleanPref implements AccountPref<bool> {
  // ignore: avoid_positional_boolean_parameters
  const BooleanPref(this.value);

  @override
  final bool value;

  @override
  String get toFormData => value ? '1' : '0';

  static BooleanPref fromInt(int value) {
    switch (value) {
      case 1:
        return const BooleanPref(true);
      case 0:
        return const BooleanPref(false);
      default:
        throw Exception('Invalid value for BooleanPref');
    }
  }
}

enum Zen implements AccountPref<int> {
  no(0),
  yes(1),
  gameAuto(2);

  const Zen(this.value);

  @override
  final int value;

  @override
  String get toFormData => value.toString();

  String label(BuildContext context) {
    switch (this) {
      case Zen.no:
        return context.l10n.no;
      case Zen.yes:
        return context.l10n.yes;
      case Zen.gameAuto:
        return context.l10n.preferencesInGameOnly;
    }
  }

  static Zen fromInt(int value) {
    switch (value) {
      case 0:
        return Zen.no;
      case 1:
        return Zen.yes;
      case 2:
        return Zen.gameAuto;
      default:
        throw Exception('Invalid value for Zen');
    }
  }
}

enum AutoQueen implements AccountPref<int> {
  never(1),
  premove(2),
  always(3);

  const AutoQueen(this.value);

  @override
  final int value;

  @override
  String get toFormData => value.toString();

  String label(BuildContext context) {
    switch (this) {
      case AutoQueen.never:
        return context.l10n.never;
      case AutoQueen.premove:
        return context.l10n.preferencesWhenPremoving;
      case AutoQueen.always:
        return context.l10n.always;
    }
  }

  static AutoQueen fromInt(int value) {
    switch (value) {
      case 1:
        return AutoQueen.never;
      case 2:
        return AutoQueen.premove;
      case 3:
        return AutoQueen.always;
      default:
        throw Exception('Invalid value for AutoQueen');
    }
  }
}
