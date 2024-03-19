enum SupportedLocale {
  fr('🇫🇷', 'Français'),
  en('🇬🇧', 'English');

  const SupportedLocale(this.emoji, this.localized);

  final String emoji;
  final String localized;

  static SupportedLocale? fromName(String name) {
    switch (name) {
      case 'en':
        return SupportedLocale.en;
      case 'fr':
        return SupportedLocale.fr;
      default:
        return null;
    }
  }
}
