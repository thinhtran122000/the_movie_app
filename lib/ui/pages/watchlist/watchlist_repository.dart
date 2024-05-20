import 'package:tmdb/api/api.dart';
import 'package:tmdb/api/src/src.dart';
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
  }) async =>
      WatchlistService(apiClient: restApiClient).getWatchListMovie(
        accountId: accountId,
        sessionId: sessionId,
        language: language,
        sortBy: sortBy,
        page: page,
      );

  Future<ListResponse<MultipleMedia>> getWatchListTv({
    required String language,
    required int accountId,
    required String sessionId,
    String? sortBy,
    required int page,
  }) async =>
      WatchlistService(apiClient: restApiClient).getWatchListTv(
        accountId: accountId,
        sessionId: sessionId,
        language: language,
        sortBy: sortBy,
        page: page,
      );

  Future<ObjectResponse<MediaState>> getMovieState({
    required int movieId,
    required String sessionId,
  }) async {
    return StateService(apiClient: restApiClient).getMovieState(
      movieId: movieId,
      sessionId: sessionId,
    );
  }

  Future<ObjectResponse<MediaState>> getTvState({
    required int seriesId,
    required String sessionId,
  }) async {
    return StateService(apiClient: restApiClient).getTvState(
      seriesId: seriesId,
      sessionId: sessionId,
    );
  }

  Future<ObjectResponse<APIResponse>> addWatchList({
    required int accountId,
    required String sessionId,
    required String mediaType,
    required int mediaId,
    required bool watchlist,
  }) async {
    return WatchlistService(apiClient: restApiClient).addWatchList(
      accountId: accountId,
      sessionId: sessionId,
      mediaType: mediaType,
      mediaId: mediaId,
      watchlist: watchlist,
    );
  }
}
