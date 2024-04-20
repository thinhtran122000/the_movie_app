import 'package:tmdb/api/src/tv/tv_service.dart';
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
}
