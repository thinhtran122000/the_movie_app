import 'package:tmdb/models/models.dart';

class MediaSimilars {
  int? page;
  List<MultipleMedia> results;
  int? totalPages;
  int? totalResults;

  MediaSimilars({
    this.page,
    this.results = const [],
    this.totalPages,
    this.totalResults,
  });

  factory MediaSimilars.fromJson(Map<String, dynamic> json) => MediaSimilars(
        page: json['page'],
        results: json['results'] == null
            ? []
            : List<MultipleMedia>.from(json['results'].map((x) => MultipleMedia.fromJson(x))),
        totalPages: json['total_pages'],
        totalResults: json['total_results'],
      );
}
