import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../data/models/authentication/login_with_email_response_model.dart';
import '../../data/models/user/address_details_model.dart';
import '../../data/models/user/delete_mandate_model.dart';
import '../../data/models/user/kyc_last_route.dart';
import '../../data/models/user/mandate_sip_model.dart';
import '../../data/models/user/switchable_mandate_model.dart';
import '../../data/models/user/user.dart';
import '../../data/models/user/user_bank_details_model.dart';
import '../../data/models/user/user_bank_mandate_model.dart';
import '../../data/models/user/user_mandate_details_model.dart';
import '../entities/app_error.dart';

abstract class AccountRepository {
  Future<Either<AppError, User>> doSocialLogin(Map<String, dynamic> params);

  Future<Either<AppError, LoginWithEmailResponseModel>> loginWithEmail(
      Map<String, dynamic> params);

  Future<Either<AppError, User>> verifyEmailOtp(Map<String, dynamic> params);

  Future<Either<AppError, User>> loginWithMPin(Map<String, dynamic> params);

  Future<Either<AppError, User?>> getUser({bool forceRefresh = false});

  Future<Either<AppError, void>> setUser(User user);

  Future<Either<AppError, void>> generateMobileOtp(Map<String, dynamic> params);

  Future<Either<AppError, void>> verifyMobileOtp(Map<String, dynamic> params);

  Future<Either<AppError, void>> setMPin(Map<String, dynamic> params);

  Future<Either<AppError, void>> forgotMPinGenerateOtp();

  Future<Either<AppError, void>> forgotMPinVerifyOtp(
      Map<String, dynamic> params);

  Future<Either<AppError, KycLastRouteModel>> getKycLastRoute();

  Future<Either<AppError, List<DeliveryAddressDetailsModel>>>
      getAllAddressDetails();

  Future<Either<AppError, DeliveryAddressDetailsModel>> addAddress(
      Map<String, dynamic> params);

  Future<Either<AppError, void>> deleteAddress(Map<String, dynamic> params);

  Future<Either<AppError, List<UserBank>>> getAllBankDetails();

  Future<Either<AppError, List<SwitchableMandateModel>>>
      getAllSwitchableMandates();

  Future<Either<AppError, void>> verifyDeleteMandate(
      Map<String, dynamic> params);

  Future<Either<AppError, UserBank>> getPrimaryBankDetails();

  Future<Either<AppError, UserBank>> addBankDetails(
      Map<String, dynamic> params);

  Future<Either<AppError, UserBank>> updateProfileBankIfsc(
      Map<String, dynamic> params);

  Future<Either<AppError, void>> updatePrimaryBank(FormData formData);

  Future<Either<AppError, UserMandate>> addUserMandate(
      Map<String, dynamic> params);

  Future<Either<AppError, DeleteMandateModel>> deleteUserMandate(
      Map<String, dynamic> params);

  Future<Either<AppError, List<UserMandate>>> getUserMandates();

  Future<Either<AppError, List<UserBankMandateModel>>> getUserMandatesByBank(
      Map<String, dynamic> params);

  Future<Either<AppError, UserMandate?>> getUserMandateById(
      Map<String, dynamic> params);

  Future<Either<AppError, UserMandate?>> deleteUserMandateById(
      Map<String, dynamic> queryParams);

  Future<Either<AppError, List<MandateSipModel>>> getSipsByMandate(
    Map<String, dynamic> queryParams,
  );

  Future<Either<AppError, User>> updateProfilePhoto(FormData formData);

  Future<Either<AppError, UserMandate>> authoriseMandate(
      Map<String, dynamic> params);
}
