import 'package:movie_app/model/media_sythesis.dart';

class TrendingSynthesis {
  bool? adult;
  String? backdropPath;
  List<int> genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  num? voteAverage;
  int? voteCount;
  String? name;
  String? originalName;
  String? firstAirDate;
  List<String> originCountry;
  int? gender;
  String? knownForDepartment;
  String? profilePath;
  List<Media> knownFor;

  TrendingSynthesis({
    this.adult,
    this.backdropPath,
    this.genreIds = const [],
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.name,
    this.originalName,
    this.firstAirDate,
    this.originCountry = const [],
    this.gender,
    this.knownForDepartment,
    this.profilePath,
    this.knownFor = const [],
  });

  factory TrendingSynthesis.fromJson(Map<String, dynamic> json) => TrendingSynthesis(
        adult: json['adult'],
        backdropPath: json['backdrop_path'],
        genreIds: json['genre_ids'] == null ? [] : List<int>.from(json['genre_ids'].map((x) => x)),
        id: json['id'],
        originalLanguage: json['original_language'],
        originalTitle: json['original_title'],
        overview: json['overview'],
        popularity: json['popularity'],
        posterPath: json['poster_path'],
        releaseDate: json['release_date'],
        title: json['title'],
        video: json['video'],
        voteAverage: json['vote_average'],
        voteCount: json['vote_count'],
        name: json['name'],
        originalName: json['original_name'],
        firstAirDate: json['first_air_date'],
        originCountry: json['origin_country'] == null
            ? []
            : List<String>.from(json['origin_country'].map((x) => x)),
        gender: json['gender'],
        knownForDepartment: json['known_for_department'],
        profilePath: json['profile_path'],
        knownFor: json['known_for'] == null
            ? []
            : List<Media>.from(json['known_for'].map((x) => Media.fromJson(x))),
      );
}

// class KnownFor {
//   bool? adult;
//   String? backdropPath;
//   List<int> genreIds;
//   int? id;
//   String? originalLanguage;
//   String? originalTitle;
//   String? overview;
//   double? popularity;
//   String? posterPath;
//   String? releaseDate;
//   String? title;
//   bool? video;
//   num? voteAverage;
//   int? voteCount;
//   String? name;
//   String? originalName;
//   String? firstAirDate;
//   List<String> originCountry;
//   KnownFor({
//     this.adult,
//     this.backdropPath,
//     this.genreIds = const [],
//     this.id,
//     this.originalLanguage,
//     this.originalTitle,
//     this.overview,
//     this.popularity,
//     this.posterPath,
//     this.releaseDate,
//     this.title,
//     this.video,
//     this.voteAverage,
//     this.voteCount,
//     this.name,
//     this.originalName,
//     this.firstAirDate,
//     this.originCountry = const [],
//   });

//   factory KnownFor.fromJson(Map<String, dynamic> json) => KnownFor(
//         adult: json['adult'],
//         backdropPath: json['backdrop_path'],
//         genreIds: json['genre_ids'] == null ? [] : List<int>.from(json['genre_ids'].map((x) => x)),
//         id: json['id'],
//         originalLanguage: json['original_language'],
//         originalTitle: json['original_title'],
//         overview: json['overview'],
//         popularity: json['popularity'],
//         posterPath: json['poster_path'],
//         releaseDate: json['release_date'],
//         title: json['title'],
//         video: json['video'],
//         voteAverage: json['vote_average'],
//         voteCount: json['vote_count'],
//         name: json['name'],
//         originalName: json['original_name'],
//         firstAirDate: json['first_air_date'],
//         originCountry: json['origin_country'] == null
//             ? []
//             : List<String>.from(json['origin_country'].map((x) => x)),
//       );
// }
