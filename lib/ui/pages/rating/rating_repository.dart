import 'package:tmdb/api/api.dart';
import 'package:tmdb/api/src/src.dart';
import 'package:tmdb/models/models.dart';
import 'package:tmdb/utils/rest_api_client/index.dart';

class RatingRepository {
  final RestApiClient restApiClient;
  RatingRepository({
    required this.restApiClient,
  });

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

  Future<ObjectResponse<APIResponse>> deleteRatingMovie({
    required int movieId,
    required String sessionId,
  }) async {
    return RatingService(apiClient: restApiClient).deleteRatingMovie(
      movieId: movieId,
      sessionId: sessionId,
    );
  }

  Future<ObjectResponse<APIResponse>> deleteRatingTv({
    required int seriesId,
    required String sessionId,
  }) async {
    return RatingService(apiClient: restApiClient).deleteRatingTv(
      seriesId: seriesId,
      sessionId: sessionId,
    );
  }

  Future<ObjectResponse<APIResponse>> deleteRatingTvEpisodes({
    required int seriesId,
    required int seasonNumber,
    required int episodeNumber,
    required String sessionId,
  }) async {
    return RatingService(apiClient: restApiClient).deleteRatingTvEpisodes(
      seriesId: seriesId,
      seasonNumber: seasonNumber,
      episodeNumber: seasonNumber,
      sessionId: sessionId,
    );
  }
}
