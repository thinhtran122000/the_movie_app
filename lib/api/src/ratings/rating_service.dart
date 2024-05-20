import 'package:tmdb/api/api.dart';
import 'package:tmdb/api/src/src.dart';
import 'package:tmdb/models/models.dart';
import 'package:tmdb/utils/utils.dart';

class RatingService {
  RatingService({required this.apiClient});
  APIClient apiClient;

  Future<ListResponse<MultipleMedia>> getRatedMovie({
    required String language,
    required int accountId,
    required String sessionId,
    String? sortBy,
    required int page,
  }) async {
    final request = RatingsRequest.getRatedMovie(
      accountId: accountId,
      sessionId: sessionId,
      language: language,
      sortBy: sortBy,
      page: page,
    );
    final response = await apiClient.execute(request: request);
    final listResponse =
        response.toList().map<MultipleMedia>((e) => MultipleMedia.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }

  Future<ListResponse<MultipleMedia>> getRatedTv({
    required String language,
    required int accountId,
    required String sessionId,
    String? sortBy,
    required int page,
  }) async {
    final request = RatingsRequest.getRatedTv(
      accountId: accountId,
      sessionId: sessionId,
      language: language,
      sortBy: sortBy,
      page: page,
    );
    final response = await apiClient.execute(request: request);
    final listResponse =
        response.toList().map<MultipleMedia>((e) => MultipleMedia.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }

  Future<ObjectResponse<APIResponse>> addRatingMovie({
    required String sessionId,
    required double value,
    required int movieId,
  }) async {
    final request = RatingsRequest.addRatingMovie(
      movieId: movieId,
      sessionId: sessionId,
      value: value,
    );
    final response = await apiClient.execute(request: request);
    final objectResponse = APIResponse.fromJson(response.toObject());
    return ObjectResponse(object: objectResponse);
  }

  Future<ObjectResponse<APIResponse>> addRatingTv({
    required String sessionId,
    required double value,
    required int seriesId,
  }) async {
    final request = RatingsRequest.addRatingTv(
      seriesId: seriesId,
      sessionId: sessionId,
      value: value,
    );
    final response = await apiClient.execute(request: request);
    final objectResponse = APIResponse.fromJson(response.toObject());
    return ObjectResponse(object: objectResponse);
  }

  Future<ObjectResponse<APIResponse>> addRatingTvEpisodes({
    required String sessionId,
    required double value,
    required int seriesId,
    required int seasonNumber,
    required int episodeNumber,
  }) async {
    final request = RatingsRequest.addRatingTvEpisodes(
      seriesId: seriesId,
      seasonNumber: seasonNumber,
      episodeNumber: episodeNumber,
      sessionId: sessionId,
      value: value,
    );
    final response = await apiClient.execute(request: request);
    final objectResponse = APIResponse.fromJson(response.toObject());
    return ObjectResponse(object: objectResponse);
  }

  Future<ObjectResponse<APIResponse>> deleteRatingMovie({
    required String sessionId,
    required int movieId,
  }) async {
    final request = RatingsRequest.deleteRatingMovie(
      movieId: movieId,
      sessionId: sessionId,
    );
    final response = await apiClient.execute(request: request);
    final objectResponse = APIResponse.fromJson(response.toObject());
    return ObjectResponse(object: objectResponse);
  }

  Future<ObjectResponse<APIResponse>> deleteRatingTv({
    required String sessionId,
    required int seriesId,
  }) async {
    final request = RatingsRequest.deleteRatingTv(
      seriesId: seriesId,
      sessionId: sessionId,
    );
    final response = await apiClient.execute(request: request);
    final objectResponse = APIResponse.fromJson(response.toObject());
    return ObjectResponse(object: objectResponse);
  }

  Future<ObjectResponse<APIResponse>> deleteRatingTvEpisodes({
    required int seriesId,
    required int seasonNumber,
    required int episodeNumber,
    required String sessionId,
  }) async {
    final request = RatingsRequest.deleteRatingTvEpisodes(
      seriesId: seriesId,
      seasonNumber: seasonNumber,
      episodeNumber: episodeNumber,
      sessionId: sessionId,
    );
    final response = await apiClient.execute(request: request);
    final objectResponse = APIResponse.fromJson(response.toObject());
    return ObjectResponse(object: objectResponse);
  }
}
