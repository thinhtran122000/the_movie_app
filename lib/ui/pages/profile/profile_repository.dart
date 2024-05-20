import 'package:tmdb/api/src/src.dart';
import 'package:tmdb/models/models.dart';
import 'package:tmdb/utils/utils.dart';

class ProfileRepository {
  final RestApiClient restApiClient;
  ProfileRepository({
    required this.restApiClient,
  });

  Future<ObjectResponse<TmdbProfile>> getProfile({
    required String sessionId,
  }) async =>
      AuthenticationService(apiClient: restApiClient).getProfile(
        sessionId: sessionId,
      );

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
}
