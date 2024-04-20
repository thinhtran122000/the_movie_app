import 'package:tmdb/models/models.dart';

class ArtistDetails {
  bool? adult;
  List<String> alsoKnownAs;
  String? biography;
  String? birthday;
  String? deathday;
  int? gender;
  String? homepage;
  int? id;
  String? imdbId;
  String? knownForDepartment;
  String? name;
  String? placeOfBirth;
  num? popularity;
  String? profilePath;
  // ----------- Append to response 'images' -----------
  MediaImages? images;
  // ----------- Append to response 'credits' -----------
  MediaCredits? credits;
  // ----------- Append to response 'movieCredits' -----------
  MediaCredits? movieCredits;
  // ----------- Append to response 'tvCredits' -----------
  MediaCredits? tvCredits;
  // ----------- Append to response 'combinedCredits' -----------
  MediaCredits? combinedCredits;

  ArtistDetails({
    this.adult,
    this.alsoKnownAs = const [],
    this.biography,
    this.birthday,
    this.deathday,
    this.gender,
    this.homepage,
    this.id,
    this.imdbId,
    this.knownForDepartment,
    this.name,
    this.placeOfBirth,
    this.popularity,
    this.profilePath,
    this.images,
    this.credits,
    this.movieCredits,
    this.combinedCredits,
    this.tvCredits,
  });

  factory ArtistDetails.fromJson(Map<String, dynamic> json) => ArtistDetails(
        adult: json['adult'],
        alsoKnownAs: json['also_known_as'] == null
            ? []
            : List<String>.from(json['also_known_as'].map((x) => x)),
        biography: json['biography'],
        birthday: json['birthday'],
        deathday: json['deathday'],
        gender: json['gender'],
        homepage: json['homepage'],
        id: json['id'],
        imdbId: json['imdb_id'],
        knownForDepartment: json['known_for_department'],
        name: json['name'],
        placeOfBirth: json['place_of_birth'],
        popularity: json['popularity'],
        profilePath: json['profile_path'],
        images: json['images'] == null ? null : MediaImages.fromJson(json['images']),
        credits: json['credits'] == null ? null : MediaCredits.fromJson(json['credits']),
        movieCredits:
            json['movie_credits'] == null ? null : MediaCredits.fromJson(json['movie_credits']),
        combinedCredits: json['combined_credits'] == null
            ? null
            : MediaCredits.fromJson(json['combined_credits']),
        tvCredits: json['tv_credits'] == null ? null : MediaCredits.fromJson(json['tv_credits']),
      );
}
