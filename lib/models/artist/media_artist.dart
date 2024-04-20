import 'package:tmdb/models/models.dart';

class MediaArtist {
  bool? adult;
  int? id;
  num? popularity;
  String? name;
  String? originalName;
  int? gender;
  String? knownForDepartment;
  String? profilePath;
  List<MultipleMedia> knownFor;

  MediaArtist({
    this.adult,
    this.id,
    this.popularity,
    this.name,
    this.originalName,
    this.gender,
    this.knownForDepartment,
    this.profilePath,
    this.knownFor = const [],
  });

  factory MediaArtist.fromJson(Map<String, dynamic> json) => MediaArtist(
        adult: json['adult'],
        id: json['id'],
        popularity: json['popularity'],
        name: json['name'],
        originalName: json['original_name'],
        gender: json['gender'],
        knownForDepartment: json['known_for_department'],
        profilePath: json['profile_path'],
        knownFor: json['known_for'] == null
            ? []
            : List<MultipleMedia>.from(json['known_for'].map((x) => MultipleMedia.fromJson(x))),
      );
}
