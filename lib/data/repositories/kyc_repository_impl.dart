import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../core/api/api_call_with_error.dart';
import '../../domain/entities/app_error.dart';
import '../../domain/repositories/kyc_repository.dart';
import '../data_sources/remote/kyc_remote_data_source.dart';
import '../models/kyc/bank_details_by_ifsc_model.dart';
import '../models/kyc/cheque_ocr_read_response_model.dart';
import '../models/kyc/esign_submit_response_model.dart';
import '../models/kyc/get_decentro_address_model.dart';
import '../models/kyc/get_kyc_addresss_details_model.dart';
import '../models/kyc/get_kyc_bank_details_model.dart';
import '../models/kyc/get_kyc_data_model.dart';
import '../models/kyc/get_kyc_fatca_details_model.dart';
import '../models/kyc/get_kyc_nominee_details_model.dart';
import '../models/kyc/get_kyc_personal_details_model.dart';
import '../models/kyc/get_pincode_data_model.dart';
import '../models/kyc/kyc_video_otp_response_model.dart';
import '../models/kyc/ocr_read_response_model.dart';
import '../models/kyc/verify_pan_response_model.dart';

@LazySingleton(as: KycRepository)
class KycRepositoryImpl implements KycRepository {
  final KycRemoteDataSource _kycRemoteDataSource;

  KycRepositoryImpl(this._kycRemoteDataSource);

  @override
  Future<Either<AppError, VerifyPanResponseModel>> verifyPan(
      Map<String, dynamic> params) async {
    return ApiCallWithError.call(() => _kycRemoteDataSource.verifyPan(params));
  }

  @override
  Future<Either<AppError, bool>> uploadAddressDetails(
      Map<String, dynamic> params) async {
    return ApiCallWithError.call(
        () => _kycRemoteDataSource.uploadAddressDetails(params));
  }

  @override
  Future<Either<AppError, bool>> uploadBankDetails(
      Map<String, dynamic> params) async {
    return ApiCallWithError.call(
        () => _kycRemoteDataSource.uploadBankDetails(params));
  }

  @override
  Future<Either<AppError, bool>> uploadCancelledCheque(
      FormData formData) async {
    return ApiCallWithError.call(
        () => _kycRemoteDataSource.uploadCancelledCheque(formData));
  }

  @override
  Future<Either<AppError, bool>> uploadKycVideo(FormData formData) async {
    return ApiCallWithError.call(
        () => _kycRemoteDataSource.uploadKycVideo(formData));
  }

  @override
  Future<Either<AppError, bool>> uploadNomineeDetails(
      Map<String, dynamic> params) async {
    return ApiCallWithError.call(
        () => _kycRemoteDataSource.uploadNomineeDetails(params));
  }

  @override
  Future<Either<AppError, bool>> uploadPersonalDetails(
      Map<String, dynamic> params) async {
    return ApiCallWithError.call(
        () => _kycRemoteDataSource.uploadPersonalDetails(params));
  }

  @override
  Future<Either<AppError, bool>> uploadProofOfAddress(FormData formData) async {
    return ApiCallWithError.call(
        () => _kycRemoteDataSource.uploadProofOfAddress(formData));
  }

  @override
  Future<Either<AppError, bool>> uploadProofOfIdentity(
      FormData formData) async {
    return ApiCallWithError.call(
        () => _kycRemoteDataSource.uploadProofOfIdentity(formData));
  }

  @override
  Future<Either<AppError, bool>> uploadSelfie(FormData formData) async {
    return ApiCallWithError.call(
        () => _kycRemoteDataSource.uploadSelfie(formData));
  }

  @override
  Future<Either<AppError, bool>> uploadDigitalSignature(
      FormData formData) async {
    return ApiCallWithError.call(
        () => _kycRemoteDataSource.uploadDigitalSignature(formData));
  }

  @override
  Future<Either<AppError, bool>> confirmPan(Map<String, dynamic> params) async {
    return ApiCallWithError.call(() => _kycRemoteDataSource.confirmPan(params));
  }

  @override
  Future<Either<AppError, BankDetailsByIfscModel>> getBankDetailsByIfscCode(
      Map<String, dynamic> params) async {
    return ApiCallWithError.call(
        () => _kycRemoteDataSource.getBankDetailsByIfsc(params));
  }

  @override
  Future<Either<AppError, KycVideoOtpResponseModel>> getKycVideoOtp() async {
    return ApiCallWithError.call(() => _kycRemoteDataSource.getKycVideoOtp());
  }

  @override
  Future<Either<AppError, bool>> uploadFatcaDetails(
      Map<String, dynamic> params) async {
    return ApiCallWithError.call(
        () => _kycRemoteDataSource.uploadFatcaDetails(params));
  }

  @override
  Future<Either<AppError, bool>> uploadAdhaarNumber(
      Map<String, dynamic> params) async {
    return ApiCallWithError.call(
        () => _kycRemoteDataSource.uploadAdhaarNumber(params));
  }

  @override
  Future<Either<AppError, bool>> createKycRequest(
      Map<String, dynamic> params) async {
    return ApiCallWithError.call(
        () => _kycRemoteDataSource.kycCreateRequest(params));
  }

  @override
  Future<Either<AppError, OcrReadResponseModel>> ocrRead(
      FormData formData) async {
    return ApiCallWithError.call(() => _kycRemoteDataSource.ocrRead(formData));
  }

  @override
  Future<Either<AppError, ChequeOcrReadResponseModel>> chequeOcrRead() async {
    return ApiCallWithError.call(() => _kycRemoteDataSource.chequeOcrRead());
  }

  @override
  Future<Either<AppError, ESignSubmitResponseModel>> eSignSubmit() async {
    return ApiCallWithError.call(() => _kycRemoteDataSource.eSignSubmit());
  }

  @override
  Future<Either<AppError, void>> createInvestorAccount(
      Map<String, dynamic> params) async {
    return ApiCallWithError.call(
        () => _kycRemoteDataSource.createInvestorAccount(params));
  }

  @override
  Future<Either<AppError, void>> createMfAccount(
      Map<String, dynamic> params) async {
    return ApiCallWithError.call(
        () => _kycRemoteDataSource.createMfAccount(params));
  }

  @override
  Future<Either<AppError, GetKycPersonalDetailsModel>>
      getKycPersonalDetails() async {
    return ApiCallWithError.call(
        () => _kycRemoteDataSource.getKycPersonalDetails());
  }

  @override
  Future<Either<AppError, GetKycBankDetailsModel>> getKycBankDetails() async {
    return ApiCallWithError.call(
        () => _kycRemoteDataSource.getKycBankDetails());
  }

  @override
  Future<Either<AppError, GetKycAddressDetailsModel>>
      getKycAddressDetails() async {
    return ApiCallWithError.call(
        () => _kycRemoteDataSource.getKycAddressDetails());
  }

  @override
  Future<Either<AppError, GetKycFatcaDetailsModel>> getKycFatcaDetails() async {
    return ApiCallWithError.call(
        () => _kycRemoteDataSource.getKycFatcaDetails());
  }

  @override
  Future<Either<AppError, GetKycDataModel>> getKycData() async {
    return ApiCallWithError.call(() => _kycRemoteDataSource.getKycData());
  }

  @override
  Future<Either<AppError, void>> updateESignResult(
      Map<String, dynamic> params) async {
    return ApiCallWithError.call(
        () => _kycRemoteDataSource.updateESignResult(params));
  }

  @override
  Future<Either<AppError, List<GetKycNomineeDetailsModel>>>
      getKycNomineeDetails() async {
    return ApiCallWithError.call(
        () => _kycRemoteDataSource.getKycNomineeDetails());
  }

  @override
  Future<Either<AppError, void>> deleteNomineeDetails(FormData formData) async {
    return ApiCallWithError.call(
        () => _kycRemoteDataSource.deleteNomineeDetails(formData));
  }

  @override
  Future<Either<AppError, void>> verifyBankAccount() async {
    return ApiCallWithError.call(
        () => _kycRemoteDataSource.verifyBankAccount());
  }

  @override
  Future<Either<AppError, void>> updateInvestorAccount() async {
    return ApiCallWithError.call(
        () => _kycRemoteDataSource.updateInvestorAccount());
  }

  @override
  Future<Either<AppError, void>> retakeKyc() {
    return ApiCallWithError.call(() => _kycRemoteDataSource.retakeKyc());
  }

  @override
  Future<Either<AppError, List<GetDecentroAddressModel>>> getDecentroAddress(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () => _kycRemoteDataSource.getDecentroAddress(params),
    );
  }

  @override
  Future<Either<AppError, PinCodeDataModel>> getPinCodeData(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () => _kycRemoteDataSource.getPinCodeData(params),
    );
  }
}
