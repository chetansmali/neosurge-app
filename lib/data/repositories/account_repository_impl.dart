import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../core/api/api_call_with_error.dart';
import '../../domain/entities/app_error.dart';
import '../../domain/repositories/account_repository.dart';
import '../../logger.dart';
import '../data_sources/local/account_local_data_source.dart';
import '../data_sources/local/token_local_data_source.dart';
import '../data_sources/remote/account_remote_data_source.dart';
import '../models/authentication/login_response_model.dart';
import '../models/authentication/login_with_email_response_model.dart';
import '../models/user/address_details_model.dart';
import '../models/user/delete_mandate_model.dart';
import '../models/user/kyc_last_route.dart';

import '../models/user/mandate_sip_model.dart';
import '../models/user/switchable_mandate_model.dart';
import '../models/user/user.dart';
import '../models/user/user_bank_details_model.dart';
import '../models/user/user_bank_mandate_model.dart';
import '../models/user/user_mandate_details_model.dart';

@LazySingleton(as: AccountRepository)
class AccountRepositoryImpl implements AccountRepository {
  late final AccountRemoteDataSource _accountRemoteDataSource;
  late final AccountLocalDataSource _accountLocalDataSource;
  late final TokenLocalDataSource _tokenLocalDataSource;

  AccountRepositoryImpl(this._accountRemoteDataSource,
      this._accountLocalDataSource, this._tokenLocalDataSource);

  @override
  Future<Either<AppError, User>> doSocialLogin(
      Map<String, dynamic> params) async {
    return ApiCallWithError.call(() async {
      final LoginResponseModel loginResponseModel =
          await _accountRemoteDataSource.socialLogin(params);
      await _accountLocalDataSource.cacheUser(loginResponseModel.user);
      await _tokenLocalDataSource
          .setAccessToken(loginResponseModel.accessToken);
      await _tokenLocalDataSource
          .setRefreshToken(loginResponseModel.refreshToken);
      return loginResponseModel.user;
    });
  }

  @override
  Future<Either<AppError, void>> generateMobileOtp(
      Map<String, dynamic> params) async {
    return ApiCallWithError.call(() async {
      await _accountRemoteDataSource.generateMobileOtp(params);
    });
  }

  @override
  Future<Either<AppError, void>> verifyMobileOtp(
      Map<String, dynamic> params) async {
    return ApiCallWithError.call(() async {
      await _accountRemoteDataSource.verifyMobileOtp(params);
    });
  }

  @override
  Future<Either<AppError, User?>> getUser({bool forceRefresh = false}) async {
    if (forceRefresh) {
      return ApiCallWithError.call(() async {
        final User user = await _accountRemoteDataSource.getUser();
        return user;
      });
    } else {
      return ApiCallWithError.call(() async {
        final User? user = await _accountLocalDataSource.getCachedUser();
        return user;
      });
    }
  }

  @override
  Future<Either<AppError, void>> setUser(User user) async {
    try {
      return Right(await _accountLocalDataSource.cacheUser(user));
    } on Exception {
      return const Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, LoginWithEmailResponseModel>> loginWithEmail(
      Map<String, dynamic> params) async {
    return ApiCallWithError.call(
      () => _accountRemoteDataSource.loginWithEmail(params),
    );
  }

  @override
  Future<Either<AppError, User>> verifyEmailOtp(
      Map<String, dynamic> params) async {
    return ApiCallWithError.call(() async {
      final LoginResponseModel loginResponseModel =
          await _accountRemoteDataSource.verifyEmailOtp(params);
      await _accountLocalDataSource.cacheUser(loginResponseModel.user);
      await _tokenLocalDataSource
          .setAccessToken(loginResponseModel.accessToken);
      await _tokenLocalDataSource
          .setRefreshToken(loginResponseModel.refreshToken);
      return loginResponseModel.user;
    });
  }

  @override
  Future<Either<AppError, User>> loginWithMPin(
      Map<String, dynamic> params) async {
    return ApiCallWithError.call(() async {
      final LoginResponseModel loginResponseModel =
          await _accountRemoteDataSource.loginWithMPin(params);

      await _tokenLocalDataSource
          .setAccessToken(loginResponseModel.accessToken);
      await _tokenLocalDataSource
          .setRefreshToken(loginResponseModel.refreshToken);

      var existingUser = await _accountLocalDataSource.getCachedUser();
      log('existingUser: $existingUser');

      if (existingUser != null && existingUser.smallcaseAuthToken != null) {
        var newUser = loginResponseModel.user.copyWith(
          // NOTE: Uncomment smallcaseAuthToken if don't want to logout user after login
          // smallcaseAuthToken: existingUser.smallcaseAuthToken,
          equityBroker: existingUser.equityBroker,
        );

        await _accountLocalDataSource.cacheUser(newUser);

        return newUser;
      } else {
        await _accountLocalDataSource.cacheUser(loginResponseModel.user);

        return loginResponseModel.user;
      }
    });
  }

  @override
  Future<Either<AppError, void>> setMPin(Map<String, dynamic> params) async {
    return ApiCallWithError.call(() async {
      await _accountRemoteDataSource.setMPin(params);
    });
  }

  @override
  Future<Either<AppError, KycLastRouteModel>> getKycLastRoute() async {
    return ApiCallWithError.call(() async {
      final KycLastRouteModel kycLastRouteModel =
          await _accountRemoteDataSource.getKycLastRoute();
      return kycLastRouteModel;
    });
  }

  @override
  Future<Either<AppError, DeliveryAddressDetailsModel>> addAddress(
      Map<String, dynamic> params) async {
    return ApiCallWithError.call(
        () => _accountRemoteDataSource.addAddress(params));
  }

  @override
  Future<Either<AppError, void>> deleteAddress(
      Map<String, dynamic> params) async {
    return ApiCallWithError.call(
        () => _accountRemoteDataSource.deleteAddress(params));
  }

  @override
  Future<Either<AppError, List<DeliveryAddressDetailsModel>>>
      getAllAddressDetails() async {
    return ApiCallWithError.call(
        () => _accountRemoteDataSource.getAllAddressDetails());
  }

  @override
  Future<Either<AppError, List<UserBank>>> getAllBankDetails() async {
    return ApiCallWithError.call(
        () => _accountRemoteDataSource.getAllBankDetails());
  }

  @override
  Future<Either<AppError, UserBank>> addBankDetails(
      Map<String, dynamic> params) async {
    return ApiCallWithError.call(
        () => _accountRemoteDataSource.addBankDetails(params));
  }

  @override
  Future<Either<AppError, void>> updatePrimaryBank(FormData formData) async {
    return ApiCallWithError.call(
        () => _accountRemoteDataSource.updatePrimaryBank(formData));
  }

  @override
  Future<Either<AppError, void>> forgotMPinGenerateOtp() async {
    return ApiCallWithError.call(
        () => _accountRemoteDataSource.forgotMPinGenerateOtp());
  }

  @override
  Future<Either<AppError, void>> forgotMPinVerifyOtp(
      Map<String, dynamic> params) async {
    return ApiCallWithError.call(
        () => _accountRemoteDataSource.forgotMPinVerifyOtp(params));
  }

  @override
  Future<Either<AppError, UserMandate>> addUserMandate(
      Map<String, dynamic> params) async {
    return ApiCallWithError.call(
        () => _accountRemoteDataSource.addUserMandate(params));
  }

  @override
  Future<Either<AppError, List<UserMandate>>> getUserMandates() async {
    return ApiCallWithError.call(
        () => _accountRemoteDataSource.getUserMandates());
  }

  @override
  Future<Either<AppError, UserBank>> getPrimaryBankDetails() async {
    return ApiCallWithError.call(
        () => _accountRemoteDataSource.getPrimaryBankDetails());
  }

  @override
  Future<Either<AppError, User>> updateProfilePhoto(FormData formData) {
    return ApiCallWithError.call(
        () => _accountRemoteDataSource.updateProfilePhoto(formData));
  }

  @override
  Future<Either<AppError, UserMandate?>> getUserMandateById(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _accountRemoteDataSource.getUserMandateById(params));
  }

  @override
  Future<Either<AppError, UserBank>> updateProfileBankIfsc(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _accountRemoteDataSource.updateProfileBankIfsc(params));
  }

  @override
  Future<Either<AppError, UserMandate>> authoriseMandate(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _accountRemoteDataSource.authoriseMandate(params));
  }

  @override
  Future<Either<AppError, UserMandate?>> deleteUserMandateById(
      Map<String, dynamic> queryParams) {
    return ApiCallWithError.call(
        () => _accountRemoteDataSource.deleteUserMandateById(queryParams));
  }

  @override
  Future<Either<AppError, List<UserBankMandateModel>>> getUserMandatesByBank(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () => _accountRemoteDataSource.getUserMandatesByBank(params),
    );
  }

  @override
  Future<Either<AppError, List<MandateSipModel>>> getSipsByMandate(
    Map<String, dynamic> queryParams,
  ) {
    return ApiCallWithError.call(
      () => _accountRemoteDataSource.getSipsByMandate(queryParams),
    );
  }

  @override
  Future<Either<AppError, DeleteMandateModel>> deleteUserMandate(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () => _accountRemoteDataSource.deleteUserMandate(params),
    );
  }

  @override
  Future<Either<AppError, void>> verifyDeleteMandate(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () => _accountRemoteDataSource.verifyDeleteMandate(params),
    );
  }

  @override
  Future<Either<AppError, List<SwitchableMandateModel>>>
      getAllSwitchableMandates() {
    return ApiCallWithError.call(
      () => _accountRemoteDataSource.getAllSwitchableMandates(),
    );
  }
}
