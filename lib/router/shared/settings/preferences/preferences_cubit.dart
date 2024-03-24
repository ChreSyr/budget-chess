// ignore_for_file: invalid_annotation_target

import 'dart:ui';

import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/firebase/authentication/authentication_crud.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/router/shared/settings/preferences/preferences_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class PreferencesCubit extends HydratedCubit<PreferencesState> {
  PreferencesCubit()
      : super(
          PreferencesState(
            brightness: Brightness.light,
            languageCode: defaultLocale,
            seedColor: SeedColor.orange,
          ),
        );

  void toggleTheme() => emit(
        state.copyWith(
          brightness: state.brightness == Brightness.light
              ? Brightness.dark
              : Brightness.light,
        ),
      );

  void setDarkTheme() => emit(state.copyWith(brightness: Brightness.dark));

  void setLigthTheme() => emit(state.copyWith(brightness: Brightness.light));

  void setSeedColor(SeedColor seedColor) {
    emit(state.copyWith(seedColor: seedColor));
  }

  void setLocale(String locale) {
    emit(state.copyWith(languageCode: locale));
    authenticationCRUD.setLanguageCode(locale);
  }

  void toggleLocale() {
    final newLanguageCode = state.languageCode == 'fr' ? 'en' : 'fr';
    emit(state.copyWith(languageCode: newLanguageCode));
    authenticationCRUD.setLanguageCode(newLanguageCode);
  }

  @override
  PreferencesState? fromJson(Map<String, dynamic> json) {
    return PreferencesState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(PreferencesState state) {
    return state.toJson();
  }
}
