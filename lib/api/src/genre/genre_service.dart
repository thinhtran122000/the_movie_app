import 'package:tmdb/api/api.dart';
import 'package:tmdb/api/src/genre/genre_request.dart';
import 'package:tmdb/models/genre/media_genre.dart';
import 'package:tmdb/utils/utils.dart';

class GenreService {
  GenreService({required this.apiClient});
  APIClient apiClient;
  Future<ObjectResponse<MediaGenre>> getGenreMovie({
    required String language,
  }) async {
    final request = GenreRequest.getGenreMovie(
      language: language,
    );
    final response = await apiClient.execute(request: request);
    final objectResponse = MediaGenre.fromJson(response.toObject());
    return ObjectResponse(object: objectResponse);
  }

  Future<ObjectResponse<MediaGenre>> getGenreTv({
    required String language,
  }) async {
    final request = GenreRequest.getGenreTv(
      language: language,
    );
    final response = await apiClient.execute(request: request);
    final objectResponse = MediaGenre.fromJson(response.toObject());
    return ObjectResponse(object: objectResponse);
  }
}



