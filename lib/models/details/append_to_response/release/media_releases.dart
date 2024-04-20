import 'package:tmdb/models/models.dart';

class MediaReleases {
  List<ReleaseResult> countries;

  MediaReleases({
    required this.countries,
  });

  factory MediaReleases.fromJson(Map<String, dynamic> json) => MediaReleases(
        countries: json['countries'] == null
            ? []
            : List<ReleaseResult>.from(json['countries'].map((x) => ReleaseResult.fromJson(x))),
      );
}
