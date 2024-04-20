import 'package:tmdb/models/models.dart';

class MediaKeywords {
  List<KeywordResult> keywords;

  MediaKeywords({
    required this.keywords,
  });

  factory MediaKeywords.fromJson(Map<String, dynamic> json) => MediaKeywords(
        keywords: List<KeywordResult>.from(json['keywords'].map((x) => KeywordResult.fromJson(x))),
      );
}
