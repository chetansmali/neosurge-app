// import 'dart:async';
//
// import 'package:dio/dio.dart';
//
// import '../../domain/entities/custom_exception.dart';
// import '../../domain/repositories/token_repository.dart';
// import '../../logger.dart';
// import 'api_constants.dart';
//
// class ApiInterceptor extends QueuedInterceptor {
//   final Dio _dio = Dio();
//   final TokenRepository _tokenRepository;
//
//   ApiInterceptor(this._tokenRepository);
//
//   @override
//   Future<void> onRequest(
//       RequestOptions options, RequestInterceptorHandler handler) async {
//     // Non-authenticated endpoint -> bypass this interceptor
//     if (options._requiresNoAuthentication()) {
//       options._removeAuthenticationHeader();
//       return handler.next(options);
//     }
//     final accessToken = await _tokenRepository.getAccessToken();
//     final refreshToken = await _tokenRepository.getRefreshToken();
//
//     if (accessToken == null || refreshToken == null) {
//       _logout();
//       return handler.reject(DioError(
//           requestOptions: options,
//           error: 'Session expired. Please login again'));
//     }
//
//     options._setAuthenticationHeader(accessToken);
//
//     return handler.next(options);
//   }
//
//   @override
//   Future<void> onResponse(
//       Response response, ResponseInterceptorHandler handler) async {
//     logSuccess('ApiInterceptor', response.data.toString());
//     return handler.next(response);
//   }
//
//   @override
//   Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
//     logErrorObject('ApiInterceptor', err, err.message);
//     print(err.response);
//     if (err.response?.statusCode == 401) {
//       final refreshToken = await _tokenRepository.getRefreshToken();
//       try {
//         final response = await _dio.post(
//           ApiConstants.refreshTokenEndPoint,
//           data: {"refreshToken": refreshToken},
//         );
//         if (response.statusCode == 200) {
//           final Map<String, dynamic> body = response.data['data'];
//           final String accessToken = body['accessToken'];
//           await _tokenRepository.setAccessToken(accessToken);
//           return handler.resolve(response);
//         }
//       } on DioError catch (e) {
//         if (e.response?.statusCode == 401) {
//           _logout();
//           return handler.reject(DioError(
//               requestOptions: err.requestOptions,
//               error: 'Session expired. Please login again'));
//         }
//       }
//     }
//     switch (err.type) {
//       case DioErrorType.connectTimeout:
//         return handler.reject(err);
//       case DioErrorType.sendTimeout:
//         throw TimeoutException(err.message);
//       case DioErrorType.receiveTimeout:
//         throw TimeoutException(err.message);
//       case DioErrorType.response:
//         if (err.response?.statusCode == 102) {
//           throw CustomException(errorCode: err.response?.statusCode);
//         }
//         if (err.response?.statusCode == 502) {
//           throw CustomException(errorCode: err.response?.statusCode);
//         }
//         throw CustomException(
//             errorCode: err.response?.statusCode,
//             errorMessage:
//                 err.response?.data['message'] ?? err.response?.statusMessage);
//       default:
//         throw CustomException(
//             errorCode: err.response?.statusCode,
//             errorMessage:
//                 err.response?.data['message'] ?? err.response?.statusMessage);
//     }
//     return super.onError(err, handler);
//   }
// }
//
// void _logout() async {}
//
// extension AuthRequestOptionsX on RequestOptions {
//   bool _requiresNoAuthentication() => headers['Authorization'] == 'None';
//
//   bool _hasOptionalAuthentication() => headers['Authorization'] == 'Optional';
//
//   void _setAuthenticationHeader(final String token) =>
//       headers['Authorization'] = 'Bearer $token';
//
//   void _removeAuthenticationHeader() => headers.remove('Authorization');
//
//   int get _retryAttempt => (extra['auth_retry_attempt'] as int?) ?? 0;
//
//   set _retryAttempt(final int attempt) => extra['auth_retry_attempt'] = attempt;
// }
