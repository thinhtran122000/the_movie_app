import 'package:tmdb/api/api_client/index.dart';

class WatchlistRequest {
  WatchlistRequest._();

  static APIRequest getWatchListMovie({
    required String language,
    required int accountId,
    required String sessionId,
    String? sortBy,
    required int page,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/account/$accountId/watchlist/movies',
        parameters: {
          'account_id': accountId,
          'session_id': sessionId,
          'language': language,
          'sort_by': sortBy,
          'page': page,
        },
      );

  static APIRequest getWatchListTv({
    required String language,
    required int accountId,
    required String sessionId,
    String? sortBy,
    required int page,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/account/$accountId/watchlist/tv',
        parameters: {
          'account_id': accountId,
          'session_id': sessionId,
          'language': language,
          'sort_by': sortBy,
          'page': page,
        },
      );

  static APIRequest addWatchList({
    required int accountId,
    required String sessionId,
    required String mediaType,
    required int mediaId,
    required bool watchlist,
  }) =>
      APIRequest(
        method: HTTPMethods.post,
        path: '/account/$accountId/watchlist',
        headers: {
          'accept': 'application/json',
          'content-type': 'application/json',
        },
        body: {
          'media_type': mediaType,
          'media_id': mediaId,
          'watchlist': watchlist,
        },
        parameters: {
          'account_id': accountId,
          'session_id': sessionId,
        },
      );
}
