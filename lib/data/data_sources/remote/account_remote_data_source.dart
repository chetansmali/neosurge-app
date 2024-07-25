import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';
import '../../../logger.dart';
import '../../models/authentication/login_response_model.dart';
import '../../models/authentication/login_with_email_response_model.dart';
import '../../models/user/address_details_model.dart';
import '../../models/user/delete_mandate_model.dart';
import '../../models/user/kyc_last_route.dart';

import '../../models/user/mandate_sip_model.dart';
import '../../models/user/switchable_mandate_model.dart';
import '../../models/user/user.dart';
import '../../models/user/user_bank_details_model.dart';
import '../../models/user/user_bank_mandate_model.dart';
import '../../models/user/user_mandate_details_model.dart';

abstract class AccountRemoteDataSource {
  Future<LoginResponseModel> socialLogin(Map<String, dynamic> params);

  Future<LoginWithEmailResponseModel> loginWithEmail(
      Map<String, dynamic> params);

  Future<LoginResponseModel> verifyEmailOtp(Map<String, dynamic> params);

  Future<LoginResponseModel> loginWithMPin(Map<String, dynamic> params);

  Future<User> getUser();

  Future<void> generateMobileOtp(Map<String, dynamic> params);

  Future<void> verifyMobileOtp(Map<String, dynamic> params);

  Future<void> setMPin(Map<String, dynamic> params);

  Future<void> forgotMPinGenerateOtp();

  Future<void> forgotMPinVerifyOtp(Map<String, dynamic> params);

  Future<List<DeliveryAddressDetailsModel>> getAllAddressDetails();

  Future<DeliveryAddressDetailsModel> addAddress(
      Map<String, dynamic> queryParams);

  Future<void> deleteAddress(Map<String, dynamic> queryParams);

  Future<List<UserBank>> getAllBankDetails();

  Future<UserBank> getPrimaryBankDetails();

  Future<UserBank> addBankDetails(Map<String, dynamic> queryParams);

  Future<UserBank> updateProfileBankIfsc(Map<String, dynamic> queryParams);

  Future<void> updatePrimaryBank(FormData formData);

  Future<UserMandate> addUserMandate(Map<String, dynamic> queryParams);

  Future<DeleteMandateModel> deleteUserMandate(
      Map<String, dynamic> queryParams);

  Future<void> verifyDeleteMandate(Map<String, dynamic> queryParams);

  Future<List<UserMandate>> getUserMandates();

  Future<List<SwitchableMandateModel>> getAllSwitchableMandates();

  Future<List<UserBankMandateModel>> getUserMandatesByBank(
    Map<String, dynamic> queryParams,
  );

  Future<UserMandate?> getUserMandateById(Map<String, dynamic> queryParams);

  Future<UserMandate?> deleteUserMandateById(Map<String, dynamic> queryParams);

  Future<KycLastRouteModel> getKycLastRoute();

  Future<User> updateProfilePhoto(FormData formData);

  Future<UserMandate> authoriseMandate(Map<String, dynamic> queryParams);

  Future<List<MandateSipModel>> getSipsByMandate(Map<String, dynamic> params);
}

@LazySingleton(as: AccountRemoteDataSource)
class AccountRemoteDataSourceImpl implements AccountRemoteDataSource {
  final ApiClient _client;

  AccountRemoteDataSourceImpl(this._client);

  @override
  Future<LoginResponseModel> socialLogin(Map<String, dynamic> params) async {
    final response = await _client.post(ApiConstants.socialLoginEndPoint,
        params: params, requiresToken: false);
    return LoginResponseModel.fromJson(response);
  }

  @override
  Future<void> generateMobileOtp(Map<String, dynamic> params) async {
    await _client.post(ApiConstants.generateMobileOTPEndPoint, params: params);
    return;
  }

  @override
  Future<void> verifyMobileOtp(Map<String, dynamic> params) async {
    await _client.post(ApiConstants.verifyMobileOTPEndPoint, params: params);
    return;
  }

  @override
  Future<LoginWithEmailResponseModel> loginWithEmail(
      Map<String, dynamic> params) async {
    final response = await _client.post(ApiConstants.loginWithEmailEndPoint,
        params: params, requiresToken: false);
    return LoginWithEmailResponseModel.fromJson(response);
  }

  @override
  Future<LoginResponseModel> verifyEmailOtp(Map<String, dynamic> params) async {
    final response = await _client.post(
      ApiConstants.verifyEmailOtpEndPoint,
      params: params,
      requiresToken: false,
    );

    return LoginResponseModel.fromJson(response);
  }

  @override
  Future<User> getUser() async {
    final response = await _client.get(ApiConstants.getUserEndPoint);
    return User.fromJson(response);
  }

  @override
  Future<LoginResponseModel> loginWithMPin(Map<String, dynamic> params) async {
    final response = await _client.post(ApiConstants.loginWithMPinEndPoint,
        params: params, requiresToken: false);
    return LoginResponseModel.fromJson(response);
  }

  @override
  Future<void> setMPin(Map<String, dynamic> params) async {
    await _client.post(ApiConstants.setMPinEndPoint,
        params: params, requiresToken: true);
    return;
  }

  @override
  Future<KycLastRouteModel> getKycLastRoute() async {
    final response = await _client.get(ApiConstants.getKycLastRouteEndPoint);
    return KycLastRouteModel.fromJson(response);
  }

  @override
  Future<List<DeliveryAddressDetailsModel>> getAllAddressDetails() async {
    final response =
        await _client.get(ApiConstants.getDGDeliveryAddressListEndPoint);
    return response
        .map<DeliveryAddressDetailsModel>(
            (json) => DeliveryAddressDetailsModel.fromJson(json))
        .toList();
  }

  @override
  Future<DeliveryAddressDetailsModel> addAddress(
      Map<String, dynamic> queryParams) async {
    final response = await _client
        .post(ApiConstants.addDGDeliveryAddressEndPoint, params: queryParams);
    return DeliveryAddressDetailsModel.fromJson(response);
  }

  @override
  Future<void> deleteAddress(Map<String, dynamic> queryParams) async {
    return await _client.delete(ApiConstants.deleteDGDeliveryAddressEndPoint,
        params: queryParams);
  }

  @override
  Future<List<UserBank>> getAllBankDetails() async {
    final response = await _client.get(ApiConstants.getUserBankDetailsEndPoint);
    return response.map<UserBank>((json) => UserBank.fromJson(json)).toList();
  }

  @override
  Future<UserBank> addBankDetails(Map<String, dynamic> queryParams) async {
    final response = await _client
        .post(ApiConstants.addProfileBankDetailsEndPoint, params: queryParams);
    return UserBank.fromJson(response);
  }

  @override
  Future<void> updatePrimaryBank(FormData formData) async {
    return await _client.post(
      ApiConstants.updatePrimaryBankAccountEndPoint,
      formData: formData,
      isFormData: true,
    );
  }

  @override
  Future<void> forgotMPinGenerateOtp() {
    return _client.post(ApiConstants.forgotMPinGenerateOtpEndPoint);
  }

  @override
  Future<void> forgotMPinVerifyOtp(Map<String, dynamic> params) {
    return _client.post(ApiConstants.forgotMPinVerifyOtpEndPoint,
        params: params);
  }

  @override
  Future<UserMandate> addUserMandate(Map<String, dynamic> queryParams) async {
    final response = await _client.post(ApiConstants.addUserMandateEndPoint,
        queryParams: queryParams);
    return UserMandate.fromJson(response);
  }

  @override
  Future<List<UserMandate>> getUserMandates() async {
    final response = await _client.get(ApiConstants.getUserMandatesEndPoint);
    return response
        .map<UserMandate>((json) => UserMandate.fromJson(json))
        .toList();
  }

  @override
  Future<UserBank> getPrimaryBankDetails() async {
    final response =
        await _client.get(ApiConstants.getUserPrimaryBankDetailsEndPoint);
    return UserBank.fromJson(response);
  }

  @override
  Future<User> updateProfilePhoto(FormData formData) async {
    final response = await _client.post(
        ApiConstants.addUpdateProfilePhotoEndPoint,
        formData: formData,
        isFormData: true);
    return User.fromJson(response);
  }

  @override
  Future<UserMandate?> getUserMandateById(
      Map<String, dynamic> queryParams) async {
    final response = await _client.get(ApiConstants.getUserMandateByIdEndPoint,
        queryParameters: queryParams);
    if (response == null) return null;
    return UserMandate.fromJson(response);
  }

  @override
  Future<UserBank> updateProfileBankIfsc(
      Map<String, dynamic> queryParams) async {
    final response = await _client
        .post(ApiConstants.updateProfileBankIfscEndPoint, params: queryParams);
    return UserBank.fromJson(response);
  }

  @override
  Future<UserMandate> authoriseMandate(Map<String, dynamic> queryParams) async {
    final response = await _client.post(ApiConstants.authoriseMandateEndPoint,
        queryParams: queryParams);
    return UserMandate.fromJson(response);
  }

  @override
  Future<UserMandate?> deleteUserMandateById(
      Map<String, dynamic> queryParams) async {
    final response = await _client.delete(
        ApiConstants.deleteUserMandateByIdEndPoint,
        queryParams: queryParams);
    if (response == null) return null;
    return UserMandate.fromJson(response);
  }

  @override
  Future<List<UserBankMandateModel>> getUserMandatesByBank(
      Map<String, dynamic> queryParams) async {
    final response = await _client.post(
      ApiConstants.getUserMandatesByBankEndPoint,
      params: queryParams,
      extractData: false,
    );

    return response.map<UserBankMandateModel>(
      (json) {
        return UserBankMandateModel.fromJson(json);
      },
    ).toList();
  }

  @override
  Future<List<MandateSipModel>> getSipsByMandate(
      Map<String, dynamic> params) async {
    final response = await _client.post(
      ApiConstants.getSipsByMandateEndPoint,
      params: params,
      extractData: false,
    );

    return response['sipList'].map<MandateSipModel>(
      (json) {
        return MandateSipModel.fromJson(json);
      },
    ).toList();
  }

  @override
  Future<DeleteMandateModel> deleteUserMandate(
      Map<String, dynamic> queryParams) async {
    final response = await _client.post(
      ApiConstants.deleteUserMandateEndPoint,
      params: queryParams,
      extractData: false,
    );

    return DeleteMandateModel.fromJson(response);
  }

  @override
  Future<List<SwitchableMandateModel>> getAllSwitchableMandates() async {
    final response = await _client.get(
      ApiConstants.getAllSwitchableMandatesEndPoint,
      extractData: false,
    );

    return response['mandates'].map<SwitchableMandateModel>(
      (json) {
        return SwitchableMandateModel.fromJson(json);
      },
    ).toList();
  }

  @override
  Future<void> verifyDeleteMandate(Map<String, dynamic> queryParams) async {
    return await _client.post(
      ApiConstants.verifyDeleteMandateEndPoint,
      params: queryParams,
      extractData: false,
    );
  }
}
