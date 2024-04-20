import 'package:tmdb/api/api.dart';
import 'package:tmdb/api/src/artist/artist.dart';
import 'package:tmdb/models/models.dart';
import 'package:tmdb/utils/rest_api_client/response_type.dart';

class ArtistService {
  ArtistService({required this.apiClient});
  APIClient apiClient;
  Future<ListResponse<MediaArtist>> getPopularArtist({
    required String language,
    required int page,
  }) async {
    final request = ArtistRequest.getPopularArtist(
      language: language,
      page: page,
    );
    final response = await apiClient.execute(request: request);
    final listResponse =
        response.toList().map<MediaArtist>((e) => MediaArtist.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }

  Future<ObjectResponse<ArtistDetails>> getDetailsArtist({
    required int personId,
    required String language,
    String? appendToResponse,
  }) async {
    final request = ArtistRequest.getDetailsArtist(
      personId: personId,
      language: language,
      appendToResponse: appendToResponse,
    );
    final response = await apiClient.execute(request: request);
    final objectResponse = ArtistDetails.fromJson(response.toObject());
    return ObjectResponse(object: objectResponse);
  }
}
