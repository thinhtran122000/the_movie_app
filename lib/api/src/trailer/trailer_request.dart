import 'package:tmdb/api/api.dart';

class TrailerRequest {
  TrailerRequest._();

  static APIRequest getTrailerMovie({
    required int movieId,
    required String language,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/movie/$movieId/videos',
        parameters: {
          'movie_id': movieId,
          'language': language,
        },
      );
  static APIRequest getTrailerTv({
    required int seriesId,
    required String language,
    String? includeVideoLanguage,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/tv/$seriesId/videos',
        parameters: {
          'movie_id': seriesId,
          'include_video_language': includeVideoLanguage,
          'language': language,
        },
      );
}
