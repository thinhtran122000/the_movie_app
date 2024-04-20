import 'package:tmdb/api/api_client/index.dart';
import 'package:tmdb/api/src/trailer/trailer.dart';
import 'package:tmdb/models/trailer/media_trailer.dart';
import 'package:tmdb/utils/utils.dart';

class TrailerService {
  TrailerService({required this.apiClient});
  APIClient apiClient;
  Future<ListResponse<MediaTrailer>> getTrailerMovie({
    required int movieId,
    required String language,
  }) async {
    final request = TrailerRequest.getTrailerMovie(
      movieId: movieId,
      language: language,
    );
    final response = await apiClient.execute(request: request);
    final listResponse = response.toList().map((e) => MediaTrailer.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }

  Future<ListResponse<MediaTrailer>> getTrailerTv({
    required int seriesId,
    required String language,
    String? includeVideoLanguage,
  }) async {
    final request = TrailerRequest.getTrailerTv(
      seriesId: seriesId,
      language: language,
      includeVideoLanguage: includeVideoLanguage,
    );
    final response = await apiClient.execute(request: request);
    final listResponse = response.toList().map((e) => MediaTrailer.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }
}
