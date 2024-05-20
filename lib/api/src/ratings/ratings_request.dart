import 'package:tmdb/api/api.dart';

class RatingsRequest {
  RatingsRequest._();

  static APIRequest getRatedMovie({
    required String language,
    required int accountId,
    required String sessionId,
    String? sortBy,
    required int page,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/account/$accountId/rated/movies',
        parameters: {
          'account_id': accountId,
          'session_id': sessionId,
          'language': language,
          'sort_by': sortBy,
          'page': page,
        },
      );

  static APIRequest getRatedTv({
    required String language,
    required int accountId,
    required String sessionId,
    String? sortBy,
    required int page,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/account/$accountId/rated/tv',
        parameters: {
          'account_id': accountId,
          'session_id': sessionId,
          'language': language,
          'sort_by': sortBy,
          'page': page,
        },
      );

  static APIRequest getRatedTvEpisodes({
    required String language,
    required int accountId,
    required String sessionId,
    String? sortBy,
    required int page,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/account/$accountId/rated/tv/episodes',
        parameters: {
          'account_id': accountId,
          'session_id': sessionId,
          'language': language,
          'sort_by': sortBy,
          'page': page,
        },
      );

  static APIRequest addRatingMovie({
    required int movieId,
    required double value,
    required String sessionId,
  }) =>
      APIRequest(
        method: HTTPMethods.post,
        path: '/movie/$movieId/rating',
        headers: {
          'Content-Type': 'application/json;charset=utf-8',
        },
        body: {
          'value': value,
        },
        parameters: {
          'session_id': sessionId,
        },
      );

  static APIRequest deleteRatingMovie({
    required int movieId,
    required String sessionId,
  }) =>
      APIRequest(
        method: HTTPMethods.delete,
        path: '/movie/$movieId/rating',
        headers: {
          'Content-Type': 'application/json;charset=utf-8',
        },
        parameters: {
          'session_id': sessionId,
        },
      );

  static APIRequest addRatingTv({
    required int seriesId,
    required double value,
    required String sessionId,
  }) =>
      APIRequest(
        method: HTTPMethods.post,
        path: '/tv/$seriesId/rating',
        headers: {
          'Content-Type': 'application/json;charset=utf-8',
        },
        body: {
          'value': value,
        },
        parameters: {
          'session_id': sessionId,
        },
      );

  static APIRequest deleteRatingTv({
    required int seriesId,
    required String sessionId,
  }) =>
      APIRequest(
        method: HTTPMethods.delete,
        path: '/tv/$seriesId/rating',
        headers: {
          'Content-Type': 'application/json;charset=utf-8',
        },
        parameters: {
          'session_id': sessionId,
        },
      );

  static APIRequest addRatingTvEpisodes({
    required int seriesId,
    required int seasonNumber,
    required int episodeNumber,
    required String sessionId,
    required double value,
  }) =>
      APIRequest(
        method: HTTPMethods.post,
        path: '/tv/$seriesId/season/$seasonNumber/episode/$episodeNumber/rating',
        headers: {
          'Content-Type': 'application/json;charset=utf-8',
        },
        body: {
          'value': value,
        },
        parameters: {
          'session_id': sessionId,
          'season_number': seasonNumber,
          'episode_number': episodeNumber,
        },
      );

  static APIRequest deleteRatingTvEpisodes({
    required int seriesId,
    required int seasonNumber,
    required int episodeNumber,
    required String sessionId,
  }) =>
      APIRequest(
        method: HTTPMethods.delete,
        path: '/tv/$seriesId/season/$seasonNumber/episode/$episodeNumber/rating',
        headers: {
          'Content-Type': 'application/json;charset=utf-8',
        },
        parameters: {
          'session_id': sessionId,
          'season_number': seasonNumber,
          'episode_number': episodeNumber,
        },
      );
}
