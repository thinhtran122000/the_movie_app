import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tmdb/api/api.dart';
import 'package:tmdb/api/src/src.dart';
import 'package:tmdb/models/models.dart';
import 'package:tmdb/utils/utils.dart';

class APIInterceptor extends QueuedInterceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await FlutterStorage().getValue(AppKeys.accessTokenKey);
    final expiresAt = await FlutterStorage().getValue(AppKeys.expiresAtKey);
    options.headers.addAll({'Authorization': accessToken});
    if (accessToken != null) {
      if (expiresAt != null) {
        // log('🔄 Checking token is expired or valid...');
        if (AppValidation().isExpired(expiresAt)) {
          log('⛔️\x1B[31m Token is expired! \x1B[0m');
          try {
            // final refreshToken = await SecureStorage().getRequestToken(AppKeys.requestToken);
            log('🔄 Check old token and old expired time ${await FlutterStorage().getAllValues()}');
            log('♻️\x1B[32m Refreshing token... \x1B[0m');
            final baseUrl = RestApiClient().dio.options.baseUrl;
            final dio = Dio(BaseOptions(baseUrl: baseUrl));
            // Refresh token
            final refreshTokenRequest = AuthenticationRequest.refreshToken();
            final refreshTokenResponse = await dio.request(
              refreshTokenRequest.path,
              queryParameters: refreshTokenRequest.parameters.addApiKey(),
              data: refreshTokenRequest.body,
              options: Options(
                method: refreshTokenRequest.method.value,
                contentType: Headers.jsonContentType,
              ),
            );
            final apiRefreshTokenResponse = APIResponse.fromJson(refreshTokenResponse.data);
            final refreshTokenObject = TmdbAuthentication.fromJson(apiRefreshTokenResponse.results);
            // Login again to authorize refresh token for refresh new session id
            final currentUsername = await FlutterStorage().getValue(AppKeys.usernameKey) ?? '';
            final currentPassword = await FlutterStorage().getValue(AppKeys.passwordKey) ?? '';
            final loginRequest = AuthenticationRequest.login(
              username: currentUsername,
              password: currentPassword,
              requestToken: refreshTokenObject.requestToken ?? '',
            );
            final loginResponse = await dio.request(
              loginRequest.path,
              queryParameters: loginRequest.parameters.addApiKey(),
              data: loginRequest.body,
              options: Options(
                method: loginRequest.method.value,
                contentType: Headers.jsonContentType,
              ),
            );
            final apiLoginResponse = APIResponse.fromJson(loginResponse.data);
            final loginObject = TmdbAuthentication.fromJson(apiLoginResponse.results);
            // Refresh session id
            final sessionRequest =
                AuthenticationRequest.createSession(requestToken: loginObject.requestToken ?? '');
            final sessionResponse = await dio.request(
              sessionRequest.path,
              queryParameters: sessionRequest.parameters.addApiKey(),
              data: sessionRequest.body,
              options: Options(
                method: sessionRequest.method.value,
                contentType: Headers.jsonContentType,
              ),
            );
            final sessionApiResponse = APIResponse.fromJson(sessionResponse.data);
            final sessionObject = TmdbAuthentication.fromJson(sessionApiResponse.results);

            await FlutterStorage()
                .setValue(AppKeys.accessTokenKey, loginObject.requestToken ?? '')
                .then((_) => log('✅\x1B[32m Store new token successfully! \x1B[0m'));
            await FlutterStorage()
                .setValue(AppKeys.expiresAtKey, loginObject.expiresAt ?? '')
                .then((_) => log('✅\x1B[32m Store new expired time successfully! \x1B[0m'));
            await FlutterStorage()
                .setValue(AppKeys.sessionIdKey, sessionObject.sessionId ?? '')
                .then((_) => log('✅\x1B[32m Store new session id successfully! \x1B[0m'));
            log('🔄 Check all values stored ${await FlutterStorage().getAllValues()}');
            log('✅\x1B[32m Token and session id refreshed! \x1B[0m');
          } catch (e) {
            log('⛔️\x1B[31m Token refresh failed! \x1B[0m');
            log('⛔️\x1B[31m $e \x1B[0m');
          }
          // log('♻️ Add new token to header parameter');
          final String? accessToken = await FlutterStorage().getValue(AppKeys.accessTokenKey);
          options.headers.addAll({'Authorization': 'Bearer $accessToken'});
        } else {
          // log('✅\x1B[32m Current token is not expired \x1B[0m');
          options.headers.addAll({'Authorization': 'Bearer $accessToken'});
          // log('✅\x1B[32m Completely add old token to header \x1B[0m');
        }
      }
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // log('\x1B[33m=> PATH: ${response.requestOptions.baseUrl}${response.requestOptions.path}?${response.requestOptions.queryParameters.entries.toList().map((entry) => '${entry.key}=${entry.value}').join('&')}\x1B[0m');
    // log('\x1B[32m=> RESPONSE DATA: ${response.data}\x1B[0m');
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