import 'package:movie_app/api/api.dart';

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
        parameters: {
          'username': username,
          'password': password,
          'request_token': requestToken,
        },
      );

  static APIRequest refreshToken() => APIRequest(
        method: HTTPMethods.get,
        path: '/authentication/token/new',
        parameters: {},
      );
}
