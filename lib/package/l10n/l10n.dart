import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart';

const defaultLocale = 'en';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n =>
      AppLocalizations.of(this) ??
      lookupAppLocalizations(locales[defaultLocale]!);
}

const locales = {
  'en': Locale('en'),
  'fr': Locale('fr'),
};
