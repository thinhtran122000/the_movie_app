import 'package:tmdb/api/src/src.dart';
import 'package:tmdb/models/authentication/authentication.dart';
import 'package:tmdb/utils/utils.dart';

class LoginRepository {
  final RestApiClient restApiClient;
  LoginRepository({
    required this.restApiClient,
  });

  Future<ObjectResponse<TmdbAuthentication>> login({
    required String username,
    required String password,
    required String requestToken,
  }) async =>
      AuthenticationService(apiClient: restApiClient).login(
        username: username,
        password: password,
        requestToken: requestToken,
      );

  Future<ObjectResponse<TmdbAuthentication>> refreshToken() async =>
      AuthenticationService(apiClient: restApiClient).refreshToken();

  Future<ObjectResponse<TmdbAuthentication>> createSession({
    required String requestToken,
  }) async =>
      AuthenticationService(apiClient: restApiClient).createSession(
        requestToken: requestToken,
      );
}
