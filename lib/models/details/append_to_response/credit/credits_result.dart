class CreditResult {
  // Movie
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
  List<String> originCountry;
  // ----------- Append to response 'person_credits' -----------
  int? gender;
  String? knownForDepartment;
  String? profilePath;
  int? castId;
  // ----------- Append to response 'movie_credits' -----------
  String? creditId;
  String? character;
  int? order;
  String? department;
  String? job;
  // ----------- Append to response 'tv_credits' -----------
  int? episodeCount;

  CreditResult({
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
    this.originCountry = const [],
    this.gender,
    this.knownForDepartment,
    this.profilePath,
    this.castId,
    this.creditId,
    this.character,
    this.order,
    this.department,
    this.job,
    this.episodeCount,
  });

  factory CreditResult.fromJson(Map<String, dynamic> json) => CreditResult(
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
        character: json['character'],
        creditId: json['credit_id'],
        department: json['department'],
        job: json['job'],
        order: json['order'],
        episodeCount: json['episode_count'],
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
        castId: json['cast_id'],
      );
}
