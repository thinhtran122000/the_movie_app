import 'package:tmdb/api/api_client/index.dart';

class MultipleRequest {
  MultipleRequest._();

  static APIRequest getTrendingMultiple({
    required String mediaType,
    required int page,
    required String language,
    required String timeWindow,
    bool? includeAdult,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/trending/$mediaType/$timeWindow',
        parameters: {
          'media_type': mediaType,
          'time_window': timeWindow,
          'page': page,
          'language': language,
          'include_adult': includeAdult,
        },
      );

  static APIRequest getsearchMultiple({
    required String query,
    required bool includeAdult,
    required String language,
    required int page,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/search/multi',
        parameters: {
          'query': query,
          'include_adult': includeAdult,
          'language': language,
          'page': page,
        },
      );
}
