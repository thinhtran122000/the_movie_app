import 'package:tmdb/api/src/favorite/favorite.dart';
import 'package:tmdb/models/models.dart';
import 'package:tmdb/utils/utils.dart';

class FavoriteRepository {
  final RestApiClient restApiClient;
  FavoriteRepository({
    required this.restApiClient,
  });

  Future<ListResponse<MultipleMedia>> getFavoriteMovie({
    required String language,
    required int accountId,
    required String sessionId,
    String? sortBy,
    required int page,
  }) async {
    return FavoriteService(apiClient: restApiClient).getFavoriteMovie(
      accountId: accountId,
      sessionId: sessionId,
      language: language,
      sortBy: sortBy,
      page: page,
    );
  }

  Future<ListResponse<MultipleMedia>> getFavoriteTv({
    required String language,
    required int accountId,
    required String sessionId,
    String? sortBy,
    required int page,
  }) async {
    return FavoriteService(apiClient: restApiClient).getFavoriteTv(
      accountId: accountId,
      sessionId: sessionId,
      language: language,
      sortBy: sortBy,
      page: page,
    );
  }
}
