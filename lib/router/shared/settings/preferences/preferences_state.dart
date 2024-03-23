// ignore_for_file: invalid_annotation_target

import 'dart:ui';

import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'preferences_state.freezed.dart';
part 'preferences_state.g.dart';

@freezed
class PreferencesState with _$PreferencesState {
  factory PreferencesState({
    required Brightness brightness,
    required String languageCode,
    required SeedColor seedColor,
  }) = _PreferencesState;

  factory PreferencesState.fromJson(Map<String, dynamic> json) =>
      _$PreferencesStateFromJson(json);

  /// Required for the override getter
  const PreferencesState._();

  bool get isDarkMode => brightness == Brightness.dark;
}
