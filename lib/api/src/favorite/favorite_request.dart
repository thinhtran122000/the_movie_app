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
}
