import 'package:tmdb/api/api.dart';

class FavoriteRequest {
  FavoriteRequest._();

  static APIRequest getFavoriteMovie({
    required String language,
    required int accountId,
    required String sessionId,
    String? sortBy,
    required int page,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/account/$accountId/favorite/movies',
        parameters: {
          'account_id': accountId,
          'session_id': sessionId,
          'language': language,
          'sort_by': sortBy,
          'page': page,
        },
      );

  static APIRequest getFavoriteTv({
    required String language,
    required int accountId,
    required String sessionId,
    String? sortBy,
    required int page,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/account/$accountId/favorite/tv',
        parameters: {
          'account_id': accountId,
          'session_id': sessionId,
          'language': language,
          'sort_by': sortBy,
          'page': page,
        },
      );

  static APIRequest addFavorite({
    required int accountId,
    required String sessionId,
    required String mediaType,
    required int mediaId,
    required bool favorite,
  }) =>
      APIRequest(
        method: HTTPMethods.post,
        path: '/account/$accountId/favorite',
        headers: {
          'accept': 'application/json',
          'content-type': 'application/json',
        },
        body: {
          'media_type': mediaType,
          'media_id': mediaId,
          'favorite': favorite,
        },
        parameters: {
          'account_id': accountId,
          'session_id': sessionId,
        },
      );
}
