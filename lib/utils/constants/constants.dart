class AppConstants {
  static const String kApiKey = 'a8af9cd080f1c0b752e0ebd8edf81720';
  static const String kImagePathPoster = 'https://image.tmdb.org/t/p/w500';
  static const String kImagePathBackdrop = 'https://image.tmdb.org/t/p/w1280';
  static const Map<String, dynamic> defaultParameters = {
    'api_key': AppConstants.kApiKey,
  };

  static const String popularMovieHeroTag = 'popular-movie-hero';
  static const String trendingMovieHeroTag = 'trending-movie-hero';
  static const String topratedMovieHeroTag = 'top-rated-movie-hero';
  static const String trailerMovieHeroTag = 'trailer-movie-hero';
  static const String trailerTvHeroTag = 'trailer-tv-hero';
  static const String upcomingMovieHeroTag = 'upcoming-movie-hero';
  static const String nowPlayingTvHeroTag = 'now-playing-tv-hero';
  static const String topTvHeroTag = 'top-tv-hero';
  static const String bestDramaTvHeroTag = 'best-drama-tv-hero';
  static const String artistHeroTag = 'artist-hero';
}
