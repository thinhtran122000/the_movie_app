import 'package:tmdb/api/api.dart';
import 'package:tmdb/api/src/src.dart';
import 'package:tmdb/models/models.dart';
import 'package:tmdb/utils/utils.dart';

class DetailsRepository {
  final RestApiClient restApiClient;
  DetailsRepository({
    required this.restApiClient,
  });

  Future<ObjectResponse<MultipleDetails>> getDetailsTv({
    required String language,
    required int tvId,
    String? appendToResponse,
  }) async {
    return TvService(apiClient: restApiClient).getDetailsTv(
      language: language,
      tvId: tvId,
      appendToResponse: appendToResponse,
    );
  }

  Future<ObjectResponse<MultipleDetails>> getDetailsMovie({
    required String language,
    required int movieId,
    String? appendToResponse,
  }) async {
    return MovieService(apiClient: restApiClient).getDetailsMovie(
      language: language,
      movieId: movieId,
      appendToResponse: appendToResponse,
    );
  }

  Future<ObjectResponse<MediaImages>> getImagesMovie({
    required String language,
    required int movieId,
    String? includeImageLanguage,
  }) async {
    return MovieService(apiClient: restApiClient).getImagesMovie(
      language: language,
      movieId: movieId,
      includeImageLanguage: includeImageLanguage,
    );
  }

  Future<ObjectResponse<MediaImages>> getImagesTv({
    required String language,
    required int seriesId,
    String? includeImageLanguage,
  }) async {
    return TvService(apiClient: restApiClient).getImagesTv(
      language: language,
      seriesId: seriesId,
      includeImageLanguage: includeImageLanguage,
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

  Future<ObjectResponse<APIResponse>> addRatingMovie({
    required int movieId,
    required String sessionId,
    required double value,
  }) async {
    return RatingService(apiClient: restApiClient).addRatingMovie(
      movieId: movieId,
      sessionId: sessionId,
      value: value,
    );
  }

  Future<ObjectResponse<APIResponse>> addRatingTv({
    required int seriesId,
    required String sessionId,
    required double value,
  }) async {
    return RatingService(apiClient: restApiClient).addRatingTv(
      seriesId: seriesId,
      sessionId: sessionId,
      value: value,
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

  Future<ObjectResponse<MediaCredits>> getMovieCredits({
    required int movieId,
    required String language,
  }) async {
    return MovieService(apiClient: restApiClient).getMovieCredits(
      movieId: movieId,
      language: language,
    );
  }

  Future<ObjectResponse<MediaCredits>> getTvCredits({
    required int seriesId,
    required String language,
  }) async {
    return TvService(apiClient: restApiClient).getTvCredits(
      seriesId: seriesId,
      language: language,
    );
  }

  Future<ListResponse<MultipleMedia>> getMovieRelated({
    required String language,
    required int movieId,
    required int page,
  }) async {
    return MovieService(apiClient: restApiClient).getMovieRelated(
      movieId: movieId,
      language: language,
      page: page,
    );
  }

  Future<ListResponse<MultipleMedia>> getTvRelated({
    required String language,
    required int seriesId,
    required int page,
  }) async {
    return TvService(apiClient: restApiClient).getTvRelated(
      seriesId: seriesId,
      language: language,
      page: page,
    );
  }
}
