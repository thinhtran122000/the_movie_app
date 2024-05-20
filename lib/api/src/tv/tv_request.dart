import 'package:tmdb/api/api.dart';

class TvRequest {
  TvRequest._();

  static APIRequest getNowPlayingTv({
    required String language,
    required int page,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/tv/airing_today',
        parameters: {
          'language': language,
          'page': page,
        },
      );

  static APIRequest getPopularTv({
    required String language,
    required int page,
    String? region,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/tv/popular',
        parameters: {
          'language': language,
          'page': page,
          'region': region,
        },
      );

  static APIRequest getUpcomingTv({
    required String language,
    required int page,
    String? timezone,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/tv/on_the_air',
        parameters: {
          'language': language,
          'page': page,
          'timezone': timezone,
        },
      );

  static APIRequest getTopRatedTv({
    required String language,
    required int page,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/tv/top_rated',
        parameters: {
          'language': language,
          'page': page,
        },
      );

  static APIRequest getDiscoverTv({
    required String language,
    required int page,
    List<int> withGenres = const [],
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/discover/tv',
        parameters: {
          'language': language,
          'page': page,
          'with_genres': withGenres,
        },
      );

  static APIRequest getDetailsTv({
    required String language,
    required int tvId,
    String? appendToResponse,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/tv/$tvId',
        parameters: {
          'language': language,
          'tv_id': tvId,
          'append_to_response': appendToResponse,
        },
      );

  static APIRequest getImagesTv({
    required String language,
    required int seriesId,
    String? includeImageLanguage,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/tv/$seriesId/images',
        parameters: {
          'language': language,
          'series_id': seriesId,
          'include_image_language': includeImageLanguage,
        },
      );

  static APIRequest getTvCredits({
    required String language,
    required int seriesId,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/tv/$seriesId/credits',
        parameters: {
          'language': language,
          'series_id': seriesId,
        },
      );

  static APIRequest getTvRelated({
    required String language,
    required int seriesId,
    required int page,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/tv/$seriesId/similar',
        parameters: {
          'series_id': seriesId,
          'language': language,
          'page': page,
        },
      );
}
