import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tmdb/api/api.dart';
import 'package:tmdb/api/src/src.dart';
import 'package:tmdb/models/models.dart';
import 'package:tmdb/utils/utils.dart';

class APIInterceptor extends QueuedInterceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await SecureStorage().getValue(AppKeys.accessTokenKey);
    final expiresAt = await SecureStorage().getValue(AppKeys.expiresAtKey);
    options.headers.addAll({'Authorization': accessToken});
    if (accessToken != null) {
      if (expiresAt != null) {
        log('♻️ Checking token is expired or valid...');
        if (JwtDecoder.isExpired(expiresAt)) {
          log('♻️ Token is expired!');
          try {
            // final refreshToken = await SecureStorage().getRequestToken(AppKeys.requestToken);
            log('♻️ Refreshing token...');
            log('♻️ Check old token and old expired time ${await SecureStorage().getAllValues()}');
            log('♻️ Calling the api to refresh the token is in progress...');
            final request = AuthenticationRequest.refreshToken();
            final baseUrl = RestApiClient().dio.options.baseUrl;
            final dio = Dio(BaseOptions(baseUrl: baseUrl));
            final response = await dio.request(
              request.path,
              queryParameters: request.parameters.addApiKey(),
              data: request.body,
              options: Options(
                method: request.method.value,
                contentType: Headers.jsonContentType,
              ),
            );
            final apiResponse = APIResponse.fromJson(response.data);
            final object = TmdbAuthentication.fromJson(apiResponse.results);
            log('♻️ Get new token successfully! - new token : ${object.requestToken}');
            log('♻️ Get new expired time successfully! - new expired time : ${object.expiresAt}');
            await SecureStorage().setValue(AppKeys.accessTokenKey, object.requestToken ?? '');
            await SecureStorage().setValue(AppKeys.expiresAtKey, object.expiresAt ?? '');
            log('♻️ Store new token and new expired time successfully}');
            log('♻️ Token refreshed!');
            log('♻️ Check new token and new expired time stored ${await SecureStorage().getAllValues()}');
          } catch (e) {
            log('⛔️ Token refresh failed!');
          }
          log('♻️ Add new token to header parameter');
          final String? accessToken = await SecureStorage().getValue(AppKeys.accessTokenKey);
          options.headers.addAll({'Authorization': 'Bearer $accessToken'});
        } else {
          log('♻️ Add old token is not expired');
          log('♻️ Add old token to header parameter');
          options.headers.addAll({'Authorization': 'Bearer $accessToken'});
        }
      }
    }

    super.onRequest(options, handler);
    // log('[${options.method}] ${options.path}');
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // log('=> PATH: ${response.requestOptions.baseUrl}${response.requestOptions.path}?${response.requestOptions.queryParameters}');
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



// class ApiInterceptor extends Interceptor {
//   final SharedPrefService _sharedPrefService = SharedPrefService();

//     @override
//     void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//       print('REQUEST ApiInterceptor[${options.method}] => PATH: ${options.path}');
//       super.onRequest(options, handler);
//     }

//     @override
//     void onResponse(Response response, ResponseInterceptorHandler handler) {
//       print(
//         'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
//       );
//       super.onResponse(response, handler);
//     }

//     @override
//     void onError(DioException err, ErrorInterceptorHandler handler) async {
//       print(
//         'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
//       );
//       switch (err.response?.statusCode) {
//         case 404:
//           Fluttertoast.showToast(msg: '400 - Not found');
//           handler.reject(err);
//           break;
//         case 401:
//           print('FirstToken[${_sharedPrefService.userToken}]');
//           Fluttertoast.showToast(msg: '401 - Unauthorized.');
//           if (_sharedPrefService.userToken != null &&
//               _sharedPrefService.userRefreshToken != null) {
//             await _refreshToken();
//             print('EndToken[${_sharedPrefService.userToken}]');
//           }
//           handler.reject(err);
//           break;
//         case 500:
//           Fluttertoast.showToast(msg: '500 - Internal Server Error.');
//           handler.reject(err);

//           break;
//         case 501:
//           Fluttertoast.showToast(msg: '501 - Not Implemented Server Error.');
//           handler.reject(err);

//           break;
//         case 502:
//           Fluttertoast.showToast(msg: '502 - Bad Gateway Server Error.');
//           handler.reject(err);

//           break;
//         default:
//           Fluttertoast.showToast(
//             msg:
//                 '${err.response?.statusCode} - Something went wrong while trying to connect with the server',
//           );
//           handler.reject(err);

//           break;
//       }
//     }
//   }

//   Future<void> _refreshToken() async {
//     final SharedPrefService sharedPrefService = SharedPrefService();
//     final dio = Dio();
//     final response =
//         await dio.post(BaseApiService.baseUrl + ApiEndpoint.refreshToken, data: {
//       "accessToken": sharedPrefService.userToken,
//       "refreshToken": sharedPrefService.userRefreshToken,
//     });
//     if (response.statusCode == 200) {
//       Token token = Token.fromJson(response.data as Map<String, dynamic>);
//       await sharedPrefService.setUserToken(userToken: token.accessToken);
//       await sharedPrefService.setUserRefreshToken(
//           userRefreshToken: token.refreshToken);
//     }
//   }