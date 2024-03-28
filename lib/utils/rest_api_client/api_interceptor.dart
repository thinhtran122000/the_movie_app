import 'dart:developer';

import 'package:dio/dio.dart';

class APIInterceptor extends QueuedInterceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // if (accessToken != null) {
    //   if (JwtDecoder.isExpired(accessToken)) {
    //     try {
    // log('♻️ Refreshing token...');
    //       final refreshToken = storage.getValue(AppDatabaseKey.refreshToken);
    //       final request =
    //           AuthenticationRequest.refreshToken(refreshToken: refreshToken);

    //       final baseUrl = ApiClient().dio.options.baseUrl;
    //       final dio = Dio(BaseOptions(baseUrl: baseUrl));

    //       final response = await dio.request(
    //         request.path,
    //         queryParameters: request.parameters,
    //         data: request.body,
    //         options: Options(
    //           method: request.method.value,
    //           contentType: Headers.jsonContentType,
    //         ),
    //       );

    //       final apiResponse = APIResponse.fromJson(response.data);
    //       final object = Authentication.fromJson(apiResponse.data);

    //       await storage.setValue(
    //           AppDatabaseKey.accessToken, object.accessToken);

    //       log('♻️ Token refreshed!');
    //     } catch (e) {
    //       log('⛔️ Token refresh failed!');
    //     }

    //     final String? accessToken =
    //         storage.getValue(AppDatabaseKey.accessToken);
    //     options.headers.addAll({'Authorization': 'Bearer $accessToken'});
    //   } else {
    //     options.headers.addAll({'Authorization': 'Bearer $accessToken'});
    //   }
    // }

    super.onRequest(options, handler);
    // log('[${options.method}] ${options.path}');
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('=> PATH: ${response.requestOptions.baseUrl}${response.requestOptions.path}?${response.requestOptions.queryParameters}');
    // log('=> RESPONSE DATA: ${response.data}');
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
