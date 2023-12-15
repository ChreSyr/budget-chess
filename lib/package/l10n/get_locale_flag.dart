
String getLocaleFlag(String code) {
  switch (code) {
    case 'en':
      return '🇬🇧';
    case 'fr':
      return '🇫🇷';
    default:
      return '🐛'; // bug
  }
}
