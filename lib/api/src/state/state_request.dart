import 'package:tmdb/api/api_client/index.dart';

class StateRequest {
  StateRequest._();
  static APIRequest getMovieState({
    required int movieId,
    required String sessionId,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/movie/$movieId/account_states',
        parameters: {
          'movie_id': movieId,
          'session_id': sessionId,
        },
      );

  static APIRequest getTvState({
    required int seriesId,
    required String sessionId,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/tv/$seriesId/account_states',
        parameters: {
          'series_id': seriesId,
          'session_id': sessionId,
        },
      );
}
