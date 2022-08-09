class Language {
  String languageCode;
  String englishName;

  Language(
    String languageCode,
    String englishName,
  ) {
    this.languageCode = languageCode;
    this.englishName = englishName;
  }

  static List<Language> getAll() {
    List<Language> result = <Language>[];

    result.add(Language('en', 'English'));
    result.add(Language('zh', 'Chinese'));
    result.add(Language('hi', 'Hindi'));
    result.add(Language('es', 'Spanish'));
    result.add(Language('ar', 'Arabic'));
    result.add(Language('ms', 'Malay'));
    result.add(Language('ru', 'Russian'));
    result.add(Language('bn', 'Bengali'));
    result.add(Language('pt', 'Portuguese'));
    result.add(Language('fr', 'French'));
    result.add(Language('de', 'German'));

    return result;
  }
}
