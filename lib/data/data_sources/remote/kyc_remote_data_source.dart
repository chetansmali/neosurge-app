import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';
import '../../models/kyc/bank_details_by_ifsc_model.dart';
import '../../models/kyc/cheque_ocr_read_response_model.dart';
import '../../models/kyc/esign_submit_response_model.dart';
import '../../models/kyc/get_decentro_address_model.dart';
import '../../models/kyc/get_kyc_addresss_details_model.dart';
import '../../models/kyc/get_kyc_bank_details_model.dart';
import '../../models/kyc/get_kyc_data_model.dart';
import '../../models/kyc/get_kyc_fatca_details_model.dart';
import '../../models/kyc/get_kyc_nominee_details_model.dart';
import '../../models/kyc/get_kyc_personal_details_model.dart';
import '../../models/kyc/get_pincode_data_model.dart';
import '../../models/kyc/kyc_video_otp_response_model.dart';
import '../../models/kyc/ocr_read_response_model.dart';
import '../../models/kyc/verify_pan_response_model.dart';

abstract class KycRemoteDataSource {
  Future<VerifyPanResponseModel> verifyPan(Map<String, dynamic> uploadParams);

  Future<bool> confirmPan(Map<String, dynamic> uploadParams);

  Future<bool> uploadPersonalDetails(Map<String, dynamic> uploadParams);

  Future<bool> uploadFatcaDetails(Map<String, dynamic> uploadParams);

  Future<List<GetDecentroAddressModel>> getDecentroAddress(
      Map<String, dynamic> uploadParams);

  Future<bool> uploadAddressDetails(Map<String, dynamic> uploadParams);

  Future<bool> uploadNomineeDetails(Map<String, dynamic> uploadParams);

  Future<void> deleteNomineeDetails(FormData formData);

  Future<bool> uploadBankDetails(Map<String, dynamic> uploadParams);

  Future<void> verifyBankAccount();

  Future<bool> uploadSelfie(FormData formData);

  Future<bool> uploadAdhaarNumber(Map<String, dynamic> uploadParams);

  Future<bool> uploadKycVideo(FormData formData);

  Future<bool> uploadDigitalSignature(FormData formData);

  Future<bool> uploadCancelledCheque(FormData formData);

  Future<bool> uploadProofOfIdentity(FormData formData);

  Future<bool> uploadProofOfAddress(FormData formData);

  Future<bool> kycCreateRequest(Map<String, dynamic> uploadParams);

  Future<OcrReadResponseModel> ocrRead(FormData formData);

  Future<ChequeOcrReadResponseModel> chequeOcrRead();

  Future<BankDetailsByIfscModel> getBankDetailsByIfsc(
      Map<String, dynamic> uploadParams);

  Future<KycVideoOtpResponseModel> getKycVideoOtp();

  Future<ESignSubmitResponseModel> eSignSubmit();

  Future<void> updateESignResult(Map<String, dynamic> uploadParams);

  Future<void> createInvestorAccount(Map<String, dynamic> queryParams);

  Future<void> updateInvestorAccount();

  Future<void> createMfAccount(Map<String, dynamic> queryParams);

  ///Fetch Data Functions
  Future<GetKycAddressDetailsModel> getKycAddressDetails();

  Future<GetKycPersonalDetailsModel> getKycPersonalDetails();

  Future<List<GetKycNomineeDetailsModel>> getKycNomineeDetails();

  Future<GetKycBankDetailsModel> getKycBankDetails();

  Future<GetKycFatcaDetailsModel> getKycFatcaDetails();

  Future<GetKycDataModel> getKycData();

  Future<void> retakeKyc();

  Future<PinCodeDataModel> getPinCodeData(Map<String, dynamic> queryParams);
}

@LazySingleton(as: KycRemoteDataSource)
class KycRemoteDataSourceImpl implements KycRemoteDataSource {
  final ApiClient _client;

  KycRemoteDataSourceImpl(this._client);

  @override
  Future<bool> uploadAddressDetails(Map<String, dynamic> uploadParams) async {
    await _client.post(ApiConstants.uploadAddressDetailsEndPoint,
        params: uploadParams);
    return true;
  }

  @override
  Future<bool> uploadBankDetails(Map<String, dynamic> uploadParams) async {
    await _client.post(ApiConstants.uploadBankDetailsEndPoint,
        params: uploadParams);
    return true;
  }

  @override
  Future<bool> uploadDigitalSignature(FormData formData) async {
    await _client.post(
      ApiConstants.signatureUploadEndPoint,
      formData: formData,
      isFormData: true,
    );
    return true;
  }

  @override
  Future<bool> uploadKycVideo(FormData formData) async {
    await _client.post(
      ApiConstants.kycVideoUploadEndPoint,
      formData: formData,
      isFormData: true,
    );
    return true;
  }

  @override
  Future<bool> uploadNomineeDetails(Map<String, dynamic> uploadParams) async {
    await _client.post(ApiConstants.uploadNomineeDetailsEndPoint,
        params: uploadParams);
    return true;
  }

  @override
  Future<bool> uploadPersonalDetails(Map<String, dynamic> uploadParams) async {
    await _client.post(ApiConstants.uploadPersonalDetailsEndPoint,
        params: uploadParams);
    return true;
  }

  @override
  Future<bool> uploadProofOfAddress(FormData formData) async {
    await _client.post(ApiConstants.uploadProofOfAddressEndPoint,
        formData: formData, isFormData: true);
    return true;
  }

  @override
  Future<bool> uploadProofOfIdentity(FormData formData) async {
    await _client.post(ApiConstants.uploadProofOfIdentityOrProfilePhotoEndPoint,
        formData: formData, isFormData: true);
    return true;
  }

  @override
  Future<bool> uploadSelfie(FormData formData) async {
    await _client.post(ApiConstants.uploadProofOfIdentityOrProfilePhotoEndPoint,
        formData: formData, isFormData: true);
    return true;
  }

  @override
  Future<VerifyPanResponseModel> verifyPan(
      Map<String, dynamic> uploadParams) async {
    final response = await _client.post(ApiConstants.getPanStatusEndPoint,
        params: uploadParams);
    return VerifyPanResponseModel.fromJson(response);
  }

  @override
  Future<bool> confirmPan(Map<String, dynamic> uploadParams) async {
    await _client.post(ApiConstants.confirmPanEndPoint, params: uploadParams);
    return true;
  }

  @override
  Future<bool> uploadCancelledCheque(FormData formData) async {
    await _client.post(
      ApiConstants.cancelledChequeUploadEndPoint,
      formData: formData,
      isFormData: true,
    );
    return true;
  }

  @override
  Future<BankDetailsByIfscModel> getBankDetailsByIfsc(
      Map<String, dynamic> uploadParams) async {
    final response = await _client.get(
        ApiConstants.getBankDetailsByIfscEndPoint,
        queryParameters: uploadParams);
    return BankDetailsByIfscModel.fromJson(response);
  }

  @override
  Future<KycVideoOtpResponseModel> getKycVideoOtp() async {
    final response = await _client.get(ApiConstants.getKycVideoOtpEndPoint);
    return KycVideoOtpResponseModel.fromJson(response);
  }

  @override
  Future<bool> uploadFatcaDetails(Map<String, dynamic> uploadParams) async {
    await _client.post(ApiConstants.uploadFatcaDetailsEndPoint,
        params: uploadParams);
    return true;
  }

  @override
  Future<bool> uploadAdhaarNumber(Map<String, dynamic> uploadParams) async {
    await _client.post(ApiConstants.uploadAdhaarNumEndPoint,
        params: uploadParams);
    return true;
  }

  @override
  Future<bool> kycCreateRequest(Map<String, dynamic> uploadParams) async {
    await _client.post(ApiConstants.kycCreateRequestEndPoint,
        params: uploadParams);
    return true;
  }

  @override
  Future<OcrReadResponseModel> ocrRead(FormData formData) async {
    final response = await _client.post(ApiConstants.ocrReadingEndPoint,
        formData: formData, isFormData: true);
    return OcrReadResponseModel.fromJson(response);
  }

  @override
  Future<ChequeOcrReadResponseModel> chequeOcrRead() async {
    final response = await _client.post(
      ApiConstants.chequeOcrReadingEndPoint,
    );
    return ChequeOcrReadResponseModel.fromJson(response);
  }

  @override
  Future<ESignSubmitResponseModel> eSignSubmit() async {
    final response = await _client.post(ApiConstants.eSignSubmitEndPoint);
    return ESignSubmitResponseModel.fromJson(response);
  }

  @override
  Future<void> createInvestorAccount(Map<String, dynamic> queryParams) async {
    await _client.post(ApiConstants.createInvestorAccountEndPoint,
        queryParams: queryParams);
  }

  @override
  Future<void> createMfAccount(Map<String, dynamic> queryParams) async {
    await _client.post(ApiConstants.createMfAccountEndPoint,
        queryParams: queryParams);
  }

  @override
  Future<GetKycAddressDetailsModel> getKycAddressDetails() async {
    final response =
        await _client.get(ApiConstants.getKycAddressDetailsEndPoint);
    return GetKycAddressDetailsModel.fromJson(response);
  }

  @override
  Future<GetKycPersonalDetailsModel> getKycPersonalDetails() async {
    final response =
        await _client.get(ApiConstants.getKycPersonalDetailsEndPoint);
    return GetKycPersonalDetailsModel.fromJson(response);
  }

  @override
  Future<GetKycBankDetailsModel> getKycBankDetails() async {
    final response = await _client.get(ApiConstants.getKycBankDetailsEndPoint);
    return GetKycBankDetailsModel.fromJson(response[0]);
  }

  @override
  Future<GetKycFatcaDetailsModel> getKycFatcaDetails() async {
    final response = await _client.get(ApiConstants.getKycFatcaDetailsEndPoint);
    return GetKycFatcaDetailsModel.fromJson(response);
  }

  @override
  Future<GetKycDataModel> getKycData() async {
    final response = await _client.get(ApiConstants.getKycDataEndPoint);
    return GetKycDataModel.fromJson(response);
  }

  @override
  Future<void> updateESignResult(Map<String, dynamic> uploadParams) async {
    await _client.post(ApiConstants.updateEsignResultEndPoint,
        queryParams: uploadParams);
    return;
  }

  @override
  Future<List<GetKycNomineeDetailsModel>> getKycNomineeDetails() async {
    final res = await _client.get(ApiConstants.getKycNomineeDetailsEndPoint);
    return List<GetKycNomineeDetailsModel>.from(
      res.map((x) => GetKycNomineeDetailsModel.fromJson(x)),
    );
  }

  @override
  Future<void> deleteNomineeDetails(FormData formData) async {
    return await _client.post(ApiConstants.deleteNomineeDetailsEndPoint,
        formData: formData, isFormData: true);
  }

  @override
  Future<void> verifyBankAccount() async {
    return await _client.post(ApiConstants.verifyBankAccountEndPoint);
  }

  @override
  Future<void> updateInvestorAccount() async {
    return await _client.post(ApiConstants.updateInvestorAccountEndPoint);
  }

  @override
  Future<void> retakeKyc() async {
    return await _client.post(ApiConstants.retakeKyc);
  }

  @override
  Future<List<GetDecentroAddressModel>> getDecentroAddress(
      Map<String, dynamic> uploadParams) async {
    final response = await _client.post(
      ApiConstants.getDecentroAddressEndPoint,
      params: uploadParams,
    );

    return List<GetDecentroAddressModel>.from(
      response['addressInfo'].map(
        (x) => GetDecentroAddressModel.fromJson(x),
      ),
    );
  }

  @override
  Future<PinCodeDataModel> getPinCodeData(
      Map<String, dynamic> queryParams) async {
    final response = await _client.get(
      ApiConstants.getPinCodeDataEndPoint,
      queryParameters: queryParams,
    );

    return PinCodeDataModel.fromJson(response);
  }
}
