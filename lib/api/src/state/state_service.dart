import 'package:tmdb/api/api_client/index.dart';
import 'package:tmdb/api/src/state/state_request.dart';
import 'package:tmdb/models/models.dart';
import 'package:tmdb/utils/utils.dart';

class StateService {
  APIClient apiClient;
  StateService({required this.apiClient});
  Future<ObjectResponse<MediaState>> getMovieState({
    required int movieId,
    required String sessionId,
  }) async {
    final request = StateRequest.getMovieState(
      movieId: movieId,
      sessionId: sessionId,
    );
    final response = await apiClient.execute(request: request);
    final objectResponse = MediaState.fromJson(response.toObject());
    return ObjectResponse(object: objectResponse);
  }

  Future<ObjectResponse<MediaState>> getTvState({
    required int seriesId,
    required String sessionId,
  }) async {
    final request = StateRequest.getTvState(
      seriesId: seriesId,
      sessionId: sessionId,
    );
    final response = await apiClient.execute(request: request);
    final objectResponse = MediaState.fromJson(response.toObject());
    return ObjectResponse(object: objectResponse);
  }
}
