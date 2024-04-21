String imagePath(String file, [String extension = 'png']) =>
    'assets/images/$file.$extension';

String svgPath(String file, [String extension = 'svg']) =>
    'assets/svgs/$file.$extension';

String languageFilePath([String? languageCode]) {
  if (languageCode == null) return 'assets/i18n';
  return '"assets/i18n/$languageCode.json';
}
