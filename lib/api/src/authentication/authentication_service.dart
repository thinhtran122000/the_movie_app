import 'package:movie_app/api/api.dart';
import 'package:movie_app/api/src/src.dart';
import 'package:movie_app/models/authentication/authentication.dart';
import 'package:movie_app/utils/utils.dart';

class AuthenticationService {
  AuthenticationService({required this.apiClient});
  APIClient apiClient;
  Future<ObjectResponse<TmdbAuthentication>> login({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    final request = AuthenticationRequest.login(
      username: username,
      password: password,
      requestToken: requestToken,
    );
    final response = await apiClient.execute(request: request);
    final objectResponse = TmdbAuthentication.fromJson(response.toObject());
    return ObjectResponse(object: objectResponse);
  }

  Future<ObjectResponse<TmdbAuthentication>> refreshToken() async {
    final request = AuthenticationRequest.refreshToken();
    final response = await apiClient.execute(request: request);
    final objectResponse = TmdbAuthentication.fromJson(response.toObject());
    return ObjectResponse(object: objectResponse);
  }
}
