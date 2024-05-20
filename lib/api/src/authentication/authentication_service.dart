import 'package:tmdb/api/api.dart';
import 'package:tmdb/api/src/src.dart';
import 'package:tmdb/models/authentication/authentication.dart';
import 'package:tmdb/models/profile/tmdb_profile.dart';
import 'package:tmdb/utils/utils.dart';

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

  Future<ObjectResponse<TmdbAuthentication>> createSession({
    required String requestToken,
  }) async {
    final request = AuthenticationRequest.createSession(
      requestToken: requestToken,
    );
    final response = await apiClient.execute(request: request);
    final objectResponse = TmdbAuthentication.fromJson(response.toObject());
    return ObjectResponse(object: objectResponse);
  }

  Future<ObjectResponse<TmdbAuthentication>> deleteSession({
    required String sessionId,
  }) async {
    final request = AuthenticationRequest.deleteSession(
      sessionId: sessionId,
    );
    final response = await apiClient.execute(request: request);
    final objectResponse = TmdbAuthentication.fromJson(response.toObject());
    return ObjectResponse(object: objectResponse);
  }

  Future<ObjectResponse<TmdbProfile>> getProfile({
    required String sessionId,
  }) async {
    final request = AuthenticationRequest.getProfile(
      sessionId: sessionId,
    );
    final response = await apiClient.execute(request: request);
    final objectResponse = TmdbProfile.fromJson(response.toObject());
    return ObjectResponse(object: objectResponse);
  }
}
