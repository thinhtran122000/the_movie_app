import 'package:tmdb/api/api.dart';
import 'package:tmdb/api/src/src.dart';
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
  }) async =>
      FavoriteService(apiClient: restApiClient).getFavoriteMovie(
        accountId: accountId,
        sessionId: sessionId,
        language: language,
        sortBy: sortBy,
        page: page,
      );

  Future<ListResponse<MultipleMedia>> getFavoriteTv({
    required String language,
    required int accountId,
    required String sessionId,
    String? sortBy,
    required int page,
  }) async =>
      FavoriteService(apiClient: restApiClient).getFavoriteTv(
        accountId: accountId,
        sessionId: sessionId,
        language: language,
        sortBy: sortBy,
        page: page,
      );

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

  Future<ObjectResponse<APIResponse>> addFavorite({
    required int accountId,
    required String sessionId,
    required String mediaType,
    required int mediaId,
    required bool favorite,
  }) async {
    return FavoriteService(apiClient: restApiClient).addFavorite(
      accountId: accountId,
      sessionId: sessionId,
      mediaType: mediaType,
      mediaId: mediaId,
      favorite: favorite,
    );
  }

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
}
