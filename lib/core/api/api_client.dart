import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../common/common.dart';
import '../../domain/entities/custom_exception.dart';
import '../../domain/entities/enums.dart';
import '../../logger.dart';
import '../../presentation/routes/routes.dart';
import '../token_service.dart';

const String _h = 'api_client';

@lazySingleton
class ApiClient {
  final Dio _dio;
  final TokenService _tokenService;

  ApiClient(this._dio, this._tokenService);

  dynamic get(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool requiresToken = true,
    bool extractData = true,
  }) async {
    logInfo(_h, 'PATH:$path  QUERY PARAMS:$queryParameters');
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Authorization':
                requiresToken ? 'Bearer ${await _tokenService.getToken()}' : '',
          },
        ),
      );
      // logInfo(_h, 'Status Code : ${response.statusCode}');
      // logInfo(_h, 'Response ${response.data}');
      // logInfo(_h, 'Response data ${response.data['data']}');
      // debugPrint("print all -->\n\n\n${response.data['data']}",wrapWidth: 6000);
      return extractData ? response.data['data'] : response.data;
    } on DioException catch (e) {
      logError(_h, 'Dio Error: ${e.response?.data}');
      logErrorObject(_h, e, e.message ?? "");
      // debugPrint('Status Code : ${e.response?.statusCode}');
      // debugPrint('Status Message ${e.response?.statusMessage}');
      // debugPrint('Response ${e.response?.data}');
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw TimeoutException(e.message);
      }
      if (e.type == DioExceptionType.unknown) {
        if (e.message!.contains('SocketException')) {
          throw SocketException(e.message ?? "");
        }
      }
      if (e.type == DioExceptionType.badResponse) {
        if (e.response?.statusCode == 102) {
          throw CustomException(errorCode: e.response?.statusCode);
        }
        if (e.response?.statusCode == 502) {
          throw CustomException(errorCode: e.response?.statusCode);
        }
        if (e.response?.statusCode == 401) {
          navigatorKey.currentState!.pushReplacementNamed(Routes.logout);
          throw CustomException(errorCode: e.response?.statusCode);
        }
      }
      if (e.response?.data is Map<String, dynamic>) {
        throw CustomException(
            errorCode: e.response?.statusCode,
            errorMessage:
                e.response?.data['message'] ?? e.response?.statusMessage);
      }
      throw CustomException(
        errorCode: e.response?.statusCode,
        errorMessage: e.response?.data['message'] ?? e.response?.statusMessage,
      );
    }
  }

  dynamic post(
    String path, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? queryParams,
    bool requiresToken = true,
    bool isFormData = false,
    FormData? formData,
    bool extractData = true,
    HeaderApiKeyType? headerApiKeyType,
  }) async {
    try {
      logInfo(_h,
          'PATH:$path  PARAMS:$params queryParams:$queryParams base_url:${_dio.options.baseUrl}');
      final headers = {
        'Authorization':
            requiresToken ? 'Bearer ${await _tokenService.getToken()}' : '',
      };

      if (headerApiKeyType == HeaderApiKeyType.equity) {
        headers
            .addAll({'x-api-key': 'PYatexlXTQ2271kyVmFka7axaOQ8ie8N9hx9y37u'});
      } else if (headerApiKeyType == HeaderApiKeyType.mutualFundImport) {
        headers
            .addAll({'x-api-key': 'gEZrkQUgWn7GAzEOo2wmR7XZm8P4CbHe6P2fGNgz'});
      }

      final response = await _dio.post(
        path,
        data: isFormData ? formData! : params,
        queryParameters: queryParams,
        options: Options(
          contentType: isFormData ? Headers.formUrlEncodedContentType : null,
          headers: headers,
        ),
      );
      // logSuccess(_h, 'Response: ${response.data}');
      // logSuccess(_h, 'Data: ${response.data['data']}');
      // debugPrint("print all -->\n\n\n${response.data}",wrapWidth: 6000);

      return extractData ? response.data['data'] : response.data;
    } on DioException catch (e) {
      logError(_h, 'Dio Error: ${e.response?.data}');
      logErrorObject(_h, e, e.message ?? "");
      // debugPrint('Status Code : ${e.response?.statusCode}');
      // debugPrint('Status Message ${e.response?.statusMessage}');
      // debugPrint('Response ${e.response?.data}');

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw TimeoutException(e.message);
      }
      if (e.type == DioExceptionType.unknown) {
        if (e.message!.contains('SocketException')) {
          throw SocketException(e.message ?? "");
        }
        if (e.message!.contains('HandshakeException')) {
          throw HandshakeException(e.message ?? "");
        }
      }
      if (e.type == DioExceptionType.badResponse) {
        if (e.response?.statusCode == 401) {
          navigatorKey.currentState!.pushReplacementNamed(Routes.logout);
          throw CustomException(errorCode: e.response?.statusCode);
        }
        if (e.response?.statusCode == 102) {
          throw CustomException(errorCode: e.response?.statusCode);
        }
        if (e.response?.statusCode == 502) {
          throw CustomException(errorCode: e.response?.statusCode);
        }
      }
      if (e.response?.data is Map<String, dynamic>) {
        throw CustomException(
            errorCode: e.response?.statusCode,
            errorMessage:
                e.response?.data['message'] ?? e.response?.statusMessage);
      }
      throw CustomException(
          errorCode: e.response?.statusCode,
          errorMessage: e.response?.statusMessage);
    }
  }

  dynamic delete(
    String path, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? queryParams,
    bool requiresToken = true,
    bool isFormData = false,
    bool extractData = true,
    FormData? formData,
  }) async {
    try {
      logInfo(_h, 'PATH:$path  PARAMS:$params queryParams:$queryParams');
      final response = await _dio.delete(
        path,
        data: isFormData ? formData! : params,
        queryParameters: queryParams,
        options: Options(
          contentType: isFormData ? Headers.formUrlEncodedContentType : null,
          headers: {
            'Authorization':
                requiresToken ? 'Bearer ${await _tokenService.getToken()}' : '',
          },
        ),
      );
      // logSuccess(_h, 'Response: ${response.data}');
      // logSuccess(_h, 'Data: ${response.data['data']}');
      // debugPrint("print all -->\n\n\n${response.data}",wrapWidth: 3000);

      return extractData ? response.data['data'] : response.data;
    } on DioException catch (e) {
      logError(_h, 'Dio Error: ${e.response?.data}');
      logErrorObject(_h, e, e.message ?? "");
      // debugPrint('Status Code : ${e.response?.statusCode}');
      // debugPrint('Status Message ${e.response?.statusMessage}');
      // debugPrint('Response ${e.response?.data}');

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw TimeoutException(e.message);
      }
      if (e.type == DioExceptionType.unknown) {
        if (e.message!.contains('SocketException')) {
          throw SocketException(e.message ?? "");
        }
        if (e.message!.contains('HandshakeException')) {
          throw HandshakeException(e.message ?? "");
        }
      }
      if (e.type == DioExceptionType.badResponse) {
        if (e.response?.statusCode == 401) {
          navigatorKey.currentState!.pushReplacementNamed(Routes.logout);
          throw CustomException(errorCode: e.response?.statusCode);
        }
        if (e.response?.statusCode == 102) {
          throw CustomException(errorCode: e.response?.statusCode);
        }
        if (e.response?.statusCode == 502) {
          throw CustomException(errorCode: e.response?.statusCode);
        }
      }
      if (e.response?.data is Map<String, dynamic>) {
        throw CustomException(
            errorCode: e.response?.statusCode,
            errorMessage:
                e.response?.data['message'] ?? e.response?.statusMessage);
      }
      throw CustomException(
          errorCode: e.response?.statusCode,
          errorMessage: e.response?.statusMessage);
    }
  }
}
