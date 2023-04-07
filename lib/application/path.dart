class AppPath {
  static String image(String filename, [String extension = "png"]) =>
      "assets/images/$filename.$extension";

  static String language(String languageCode, [String extension = "json"]) =>
      "assets/i18n/$languageCode.$extension";

  static String mockData(String filename, [String extension = "json"]) =>
      "assets/mock/$filename.$extension";
}
