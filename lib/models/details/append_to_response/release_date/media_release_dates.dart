import 'package:tmdb/models/models.dart';

class MediaReleaseDates {
  List<ReleaseDateResult> releaseDates;

  MediaReleaseDates({
    required this.releaseDates,
  });

  factory MediaReleaseDates.fromJson(Map<String, dynamic> json) => MediaReleaseDates(
        releaseDates:
            List<ReleaseDateResult>.from(json['results'].map((x) => ReleaseDateResult.fromJson(x))),
      );
}
