class MultipleMedia {
  //Movie
  bool? adult;
  String? backdropPath;
  List<int> genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  num? popularity;
  String? posterPath;
  String? mediaType;
  String? releaseDate;
  String? title;
  bool? video;
  num? voteAverage;
  int? voteCount;
  // TV
  String? name;
  String? originalName;
  String? firstAirDate;
  String? lastAirDate;
  List<String> originCountry;
  // Person
  int? gender;
  String? knownForDepartment;
  String? profilePath;
  List<MultipleMedia> knownFor;
  // ----------- Append to response 'movie_credits' -----------
  String? creditId;
  // Cast
  String? character;
  int? order;
  // Crew
  String? department;
  String? job;
  // ----------- Append to response 'tv_credits' -----------
  int? episodeCount;

  MultipleMedia({
    this.adult,
    this.backdropPath,
    this.genreIds = const [],
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.mediaType,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.name,
    this.originalName,
    this.firstAirDate,
    this.lastAirDate,
    this.originCountry = const [],
    this.gender,
    this.knownForDepartment,
    this.profilePath,
    this.knownFor = const [],
  });

  factory MultipleMedia.fromJson(Map<String, dynamic> json) => MultipleMedia(
        adult: json['adult'],
        backdropPath: json['backdrop_path'],
        genreIds: json['genre_ids'] == null ? [] : List<int>.from(json['genre_ids'].map((x) => x)),
        id: json['id'],
        originalLanguage: json['original_language'],
        originalTitle: json['original_title'],
        overview: json['overview'],
        popularity: json['popularity'],
        posterPath: json['poster_path'],
        mediaType: json['media_type'],
        releaseDate: json['release_date'],
        title: json['title'],
        video: json['video'],
        voteAverage: json['vote_average'],
        voteCount: json['vote_count'],
        name: json['name'],
        originalName: json['original_name'],
        firstAirDate: json['first_air_date'],
        lastAirDate:json['last_air_date'],
        originCountry: json['origin_country'] == null
            ? []
            : List<String>.from(json['origin_country'].map((x) => x)),
        gender: json['gender'],
        knownForDepartment: json['known_for_department'],
        profilePath: json['profile_path'],
        knownFor: json['known_for'] == null
            ? []
            : List<MultipleMedia>.from(json['known_for'].map((x) => MultipleMedia.fromJson(x))),
      );
}
