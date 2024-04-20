import 'package:tmdb/models/models.dart';

class MediaTranslations {
  List<TranslationResult> translations;

  MediaTranslations({
    this.translations = const [],
  });

  factory MediaTranslations.fromJson(Map<String, dynamic> json) => MediaTranslations(
        translations: json['translations'] == null
            ? []
            : List<TranslationResult>.from(
                json['translations'].map((x) => TranslationResult.fromJson(x))),
      );
}
