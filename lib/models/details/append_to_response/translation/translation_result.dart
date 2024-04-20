import 'package:tmdb/models/models.dart';

class TranslationResult {
  String? iso31661;
  String? iso6391;
  String? name;
  String? englishName;
  Data? data;

  TranslationResult({
    this.iso31661,
    this.iso6391,
    this.name,
    this.englishName,
    this.data,
  });

  factory TranslationResult.fromJson(Map<String, dynamic> json) => TranslationResult(
        iso31661: json['iso_3166_1'],
        iso6391: json['iso_639_1'],
        name: json['name'],
        englishName: json['english_name'],
        data: json['data'] == null ? null : Data.fromJson(json['data']),
      );
}
