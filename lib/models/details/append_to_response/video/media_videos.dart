import 'package:tmdb/models/models.dart';

class MediaVideos {
  List<VideoResult> results;

  MediaVideos({
    this.results = const [],
  });

  factory MediaVideos.fromJson(Map<String, dynamic> json) => MediaVideos(
        results: json['results'] == null
            ? []
            : List<VideoResult>.from(json['results'].map((x) => VideoResult.fromJson(x))),
      );
}
