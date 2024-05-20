import 'package:tmdb/api/api.dart';

class MovieRequest {
  MovieRequest._();

  static APIRequest getPopularMovie({
    required String language,
    required int page,
    String? region,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/movie/popular',
        parameters: {
          'language': language,
          'page': page,
          'region': region,
        },
      );

  static APIRequest getUpcomingMovie({
    required String language,
    required int page,
    String? region,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/movie/upcoming',
        parameters: {
          'language': language,
          'page': page,
          'region': region,
        },
      );

  static APIRequest getTopRatedMovie({
    required String language,
    required int page,
    String? region,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/movie/top_rated',
        parameters: {
          'language': language,
          'page': page,
          'region': region,
        },
      );

  static APIRequest getNowPlayingMovie({
    required String language,
    required int page,
    String? region,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/movie/now_playing',
        parameters: {
          'language': language,
          'page': page,
          'region': region,
        },
      );
  static APIRequest getDiscoverMovie({
    required String language,
    required int page,
    List<int> withGenres = const [],
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/discover/movie',
        parameters: {
          'language': language,
          'page': page,
          'with_genres': withGenres,
          // 'region': region,
        },
      );

  static APIRequest getDetailsMovie({
    required String language,
    required int movieId,
    String? appendToResponse,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/movie/$movieId',
        parameters: {
          'language': language,
          'movie_id': movieId,
          'append_to_response': appendToResponse,
        },
      );

  static APIRequest getImagesMovie({
    required String language,
    required int movieId,
    String? includeImageLanguage,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/movie/$movieId/images',
        parameters: {
          'language': language,
          'movie_id': movieId,
          'include_image_language': includeImageLanguage,
        },
      );

  static APIRequest getMovieCredits({
    required String language,
    required int movieId,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/movie/$movieId/credits',
        parameters: {
          'language': language,
          'movie_id': movieId,
        },
      );

  static APIRequest getMovieRelated({
    required String language,
    required int movieId,
    required int page,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/movie/$movieId/similar',
        parameters: {
          'movie_id': movieId,
          'language': language,
          'page': page,
        },
      );
}
