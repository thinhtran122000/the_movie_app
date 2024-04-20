import 'package:tmdb/api/src/watchlist/watchlist.dart';
import 'package:tmdb/models/models.dart';
import 'package:tmdb/utils/utils.dart';

class WatchlistRepository {
  final RestApiClient restApiClient;
  WatchlistRepository({
    required this.restApiClient,
  });

  Future<ListResponse<MultipleMedia>> getWatchListMovie({
    required String language,
    required int accountId,
    required String sessionId,
    String? sortBy,
    required int page,
  }) async {
    return WatchlistService(apiClient: restApiClient).getWatchListMovie(
      accountId: accountId,
      sessionId: sessionId,
      language: language,
      sortBy: sortBy,
      page: page,
    );
  }

  Future<ListResponse<MultipleMedia>> getWatchListTv({
    required String language,
    required int accountId,
    required String sessionId,
    String? sortBy,
    required int page,
  }) async {
    return WatchlistService(apiClient: restApiClient).getWatchListTv(
      accountId: accountId,
      sessionId: sessionId,
      language: language,
      sortBy: sortBy,
      page: page,
    );
  }
}
