import 'package:tmdb/api/api_client/index.dart';

class ProviderRequest {
  ProviderRequest._();

  static APIRequest getMovieProvider({
    required String language,
    required String watchRegion,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/watch/providers/movie',
        parameters: {
          'language': language,
          'watch_region': watchRegion,
        },
      );

  static APIRequest getTvProvider({
    required String language,
    required String watchRegion,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/watch/providers/tv',
        parameters: {
          'language': language,
          'watch_region': watchRegion,
        },
      );
}
