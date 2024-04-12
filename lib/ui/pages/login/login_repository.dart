import 'package:movie_app/api/src/src.dart';
import 'package:movie_app/models/authentication/authentication.dart';
import 'package:movie_app/utils/utils.dart';

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
}
