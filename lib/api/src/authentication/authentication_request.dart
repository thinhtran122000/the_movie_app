import 'package:tmdb/api/api.dart';

class AuthenticationRequest {
  AuthenticationRequest._();

  static APIRequest login({
    required String username,
    required String password,
    required String requestToken,
  }) =>
      APIRequest(
        method: HTTPMethods.post,
        path: '/authentication/token/validate_with_login',
        body: {
          'username': username,
          'password': password,
          'request_token': requestToken,
        },
      );

  static APIRequest refreshToken() => APIRequest(
        method: HTTPMethods.get,
        path: '/authentication/token/new',
      );

  static APIRequest createSession({
    required String requestToken,
  }) =>
      APIRequest(
        method: HTTPMethods.post,
        path: '/authentication/session/new',
        body: {
          'request_token': requestToken,
        },
      );

  static APIRequest deleteSession({
    required String sessionId,
  }) =>
      APIRequest(
        method: HTTPMethods.delete,
        path: '/authentication/session',
        body: {
          'session_id': sessionId,
        },
      );

  static APIRequest getProfile({
    required String sessionId,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/account',
        parameters: {
          'session_id': sessionId,
        },
      );
}
