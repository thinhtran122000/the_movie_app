import 'package:tmdb/api/api.dart';

class ArtistRequest {
  ArtistRequest._();

  static APIRequest getPopularArtist({
    required String language,
    required int page,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/person/popular',
        parameters: {
          'language': language,
          'page': page,
        },
      );

  static APIRequest getDetailsArtist({
    required int personId,
    required String language,
    String? appendToResponse,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/person/$personId',
        parameters: {
          'person_id': personId,
          'language': language,
          'append_to_response': appendToResponse,
        },
      );
}
