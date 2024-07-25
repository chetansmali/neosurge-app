import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../common/common.dart';
import '../domain/entities/unauthorised_exception.dart';
import '../domain/repositories/token_repository.dart';
import '../logger.dart';
import '../presentation/routes/routes.dart';
import 'api/api_constants.dart';

const String _h = 'token_service';

@lazySingleton
class TokenService {
  final Dio _dio;
  final TokenRepository _tokenRepository;

  TokenService(this._dio, this._tokenRepository);

  Future<String> getToken() async {
    final String? accessToken = await _tokenRepository.getAccessToken();
    final String? refreshToken = await _tokenRepository.getRefreshToken();
    if (accessToken == null || refreshToken == null) {
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
        Routes.logout,
        (route) => false,
      );
      // Fluttertoast.showToast(msg: 'Session expired. Please login again');
      throw UnauthorisedException();
    } else if (JwtDecoder.isExpired(accessToken)) {
      logFatal(_h, null, 'Access token is expired');
      if (JwtDecoder.isExpired(refreshToken)) {
        logFatal(_h, null, 'Refresh token is expired');
        navigatorKey.currentState!.pushNamedAndRemoveUntil(
          Routes.logout,
          (route) => false,
        );
        Fluttertoast.showToast(msg: 'Session expired. Please login again');
        throw UnauthorisedException();
      } else {
        try {
          final response = await _dio.post(
            ApiConstants.refreshTokenEndPoint,
            data: {"refreshToken": refreshToken},
            // options:
            //     Options(headers: {'Authorisation': 'Bearer $refreshToken'})
          );
          if (response.statusCode == 200) {
            final Map<String, dynamic> body = response.data['data'];
            final String accessToken = body['accessToken'];
            await _tokenRepository.setAccessToken(accessToken);
            return accessToken;
          }
          throw "Unauthorised";
        } on DioException {
          rethrow;
        }
      }
    } else {
      logDebugFine(_h, accessToken);
      return accessToken;
    }
  }
}
