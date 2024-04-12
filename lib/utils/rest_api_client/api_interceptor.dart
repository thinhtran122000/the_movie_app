import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:movie_app/api/api.dart';
import 'package:movie_app/api/src/src.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/utils/utils.dart';

class APIInterceptor extends QueuedInterceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final requestToken = await SecureStorage().getRequestToken(AppKeys.requestTokenKey);
    final expiresAt = await SecureStorage().getRequestToken(AppKeys.expiresAtKey);
    options.headers.addAll({'Authorization': requestToken});

    if (requestToken != null) {
      if (expiresAt != null) {
        if (JwtDecoder.isExpired(expiresAt)) {
          log('♻️ Checking token is expired or valid...');
          try {
            log('♻️ Refreshing token...');
            // final refreshToken = await SecureStorage().getRequestToken(AppKeys.requestToken);
            await SecureStorage().deleteRequestToken(AppKeys.requestTokenKey);
            await SecureStorage().deleteRequestToken(AppKeys.expiresAtKey);
            log('♻️ Deleting old token...');
            final request = AuthenticationRequest.refreshToken();
            final baseUrl = RestApiClient().dio.options.baseUrl;
            final dio = Dio(BaseOptions(baseUrl: baseUrl));
            final response = await dio.request(
              request.path,
              queryParameters: request.parameters,
              data: request.body,
              options: Options(
                method: request.method.value,
                contentType: Headers.jsonContentType,
              ),
            );
            final apiResponse = APIResponse.fromJson(response.data);
            final object = TmdbAuthentication.fromJson(apiResponse.results);
            await SecureStorage()
                .setRequestToken(AppKeys.requestTokenKey, object.requestToken ?? '');
            log('♻️ Token refreshed!');
          } catch (e) {
            log('⛔️ Token refresh failed!');
          }
          final String? requestToken =
              await SecureStorage().getRequestToken(AppKeys.requestTokenKey);
          options.headers.addAll({'Authorization': 'Bearer $requestToken'});
        } else {
          options.headers.addAll({'Authorization': 'Bearer $requestToken'});
        }
      }
    }

    super.onRequest(options, handler);
    // log('[${options.method}] ${options.path}');
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('=> PATH: ${response.requestOptions.baseUrl}${response.requestOptions.path}?${response.requestOptions.queryParameters}');
    log('=> RESPONSE DATA: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    switch (err.response?.statusCode) {
      case 401:
        // await storage.deleteAll();
        // router.replaceAll([const AuthenticationRoute()]);
        return super.onError(err, handler);

      default:
        return super.onError(err, handler);
    }
  }
}
