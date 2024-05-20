import 'package:tmdb/api/api.dart';
import 'package:tmdb/api/src/src.dart';
import 'package:tmdb/models/models.dart';
import 'package:tmdb/utils/utils.dart';

class RatedRepository {
  final RestApiClient restApiClient;
  RatedRepository({
    required this.restApiClient,
  });

  Future<ListResponse<MultipleMedia>> getRatedMovie({
    required String language,
    required int accountId,
    required String sessionId,
    String? sortBy,
    required int page,
  }) async =>
      RatingService(apiClient: restApiClient).getRatedMovie(
        accountId: accountId,
        sessionId: sessionId,
        language: language,
        sortBy: sortBy,
        page: page,
      );

  Future<ListResponse<MultipleMedia>> getRatedTv({
    required String language,
    required int accountId,
    required String sessionId,
    String? sortBy,
    required int page,
  }) async =>
      RatingService(apiClient: restApiClient).getRatedTv(
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

  Future<ObjectResponse<APIResponse>> addRatingMovie({
    required String sessionId,
    required int movieId,
    required double value,
  }) async {
    return RatingService(apiClient: restApiClient).addRatingMovie(
      sessionId: sessionId,
      movieId: movieId,
      value: value,
    );
  }

  Future<ObjectResponse<APIResponse>> addRatingTv({
    required String sessionId,
    required int seriesId,
    required double value,
  }) async {
    return RatingService(apiClient: restApiClient).addRatingTv(
      sessionId: sessionId,
      seriesId: seriesId,
      value: value,
    );
  }

  Future<ObjectResponse<APIResponse>> deleteRatingMovie({
    required String sessionId,
    required int movieId,
  }) async {
    return RatingService(apiClient: restApiClient).deleteRatingMovie(
      sessionId: sessionId,
      movieId: movieId,
    );
  }

  Future<ObjectResponse<APIResponse>> deleteRatingTv({
    required String sessionId,
    required int seriesId,
  }) async {
    return RatingService(apiClient: restApiClient).deleteRatingTv(
      sessionId: sessionId,
      seriesId: seriesId,
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
}
