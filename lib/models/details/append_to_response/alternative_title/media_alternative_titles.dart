import 'package:tmdb/models/models.dart';

class MediaAlternativeTitles {
  List<AlternativeTitleResult> titles;
  List<AlternativeTitleResult> results;

  MediaAlternativeTitles({
    this.titles = const [],
    this.results = const [],
  });

  factory MediaAlternativeTitles.fromJson(Map<String, dynamic> json) => MediaAlternativeTitles(
        titles: json['titles'] == null
            ? []
            : List<AlternativeTitleResult>.from(
                json['titles'].map((x) => AlternativeTitleResult.fromJson(x))),
        results: json['results'] == null
            ? []
            : List<AlternativeTitleResult>.from(
                json['results'].map((x) => AlternativeTitleResult.fromJson(x))),
      );
}
