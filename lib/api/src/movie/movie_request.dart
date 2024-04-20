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
}
