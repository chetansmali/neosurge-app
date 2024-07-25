import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../data/models/kyc/bank_details_by_ifsc_model.dart';
import '../../data/models/kyc/cheque_ocr_read_response_model.dart';
import '../../data/models/kyc/esign_submit_response_model.dart';
import '../../data/models/kyc/get_decentro_address_model.dart';
import '../../data/models/kyc/get_kyc_addresss_details_model.dart';
import '../../data/models/kyc/get_kyc_bank_details_model.dart';
import '../../data/models/kyc/get_kyc_data_model.dart';
import '../../data/models/kyc/get_kyc_fatca_details_model.dart';
import '../../data/models/kyc/get_kyc_nominee_details_model.dart';
import '../../data/models/kyc/get_kyc_personal_details_model.dart';
import '../../data/models/kyc/get_pincode_data_model.dart';
import '../../data/models/kyc/kyc_video_otp_response_model.dart';
import '../../data/models/kyc/ocr_read_response_model.dart';
import '../../data/models/kyc/verify_pan_response_model.dart';
import '../entities/app_error.dart';

abstract class KycRepository {
  Future<Either<AppError, VerifyPanResponseModel>> verifyPan(
      Map<String, dynamic> params);

  Future<Either<AppError, bool>> confirmPan(Map<String, dynamic> params);

  Future<Either<AppError, bool>> uploadPersonalDetails(
      Map<String, dynamic> params);

  Future<Either<AppError, List<GetDecentroAddressModel>>> getDecentroAddress(
      Map<String, dynamic> params);

  Future<Either<AppError, bool>> uploadAddressDetails(
      Map<String, dynamic> params);

  Future<Either<AppError, bool>> uploadNomineeDetails(
      Map<String, dynamic> params);

  Future<Either<AppError, void>> deleteNomineeDetails(FormData formData);

  Future<Either<AppError, bool>> uploadBankDetails(Map<String, dynamic> params);

  Future<Either<AppError, void>> verifyBankAccount();

  Future<Either<AppError, bool>> uploadSelfie(FormData formData);

  Future<Either<AppError, bool>> uploadKycVideo(FormData formData);

  Future<Either<AppError, bool>> uploadProofOfIdentity(FormData formData);

  Future<Either<AppError, bool>> uploadProofOfAddress(FormData formData);

  Future<Either<AppError, bool>> uploadDigitalSignature(FormData formData);

  Future<Either<AppError, bool>> uploadCancelledCheque(FormData formData);

  Future<Either<AppError, BankDetailsByIfscModel>> getBankDetailsByIfscCode(
      Map<String, dynamic> params);

  Future<Either<AppError, KycVideoOtpResponseModel>> getKycVideoOtp();

  Future<Either<AppError, bool>> uploadFatcaDetails(
      Map<String, dynamic> params);

  Future<Either<AppError, bool>> uploadAdhaarNumber(
      Map<String, dynamic> params);

  Future<Either<AppError, bool>> createKycRequest(Map<String, dynamic> params);

  Future<Either<AppError, OcrReadResponseModel>> ocrRead(FormData formData);

  Future<Either<AppError, ChequeOcrReadResponseModel>> chequeOcrRead();

  Future<Either<AppError, ESignSubmitResponseModel>> eSignSubmit();

  Future<Either<AppError, void>> updateESignResult(Map<String, dynamic> params);

  Future<Either<AppError, void>> createInvestorAccount(
      Map<String, dynamic> params);

  Future<Either<AppError, void>> updateInvestorAccount();

  Future<Either<AppError, void>> createMfAccount(Map<String, dynamic> params);

  ///Fetch data functions

  Future<Either<AppError, GetKycPersonalDetailsModel>> getKycPersonalDetails();

  Future<Either<AppError, GetKycFatcaDetailsModel>> getKycFatcaDetails();

  Future<Either<AppError, GetKycAddressDetailsModel>> getKycAddressDetails();

  Future<Either<AppError, List<GetKycNomineeDetailsModel>>>
      getKycNomineeDetails();

  Future<Either<AppError, GetKycBankDetailsModel>> getKycBankDetails();

  Future<Either<AppError, GetKycDataModel>> getKycData();

  Future<Either<AppError, void>> retakeKyc();

  Future<Either<AppError, PinCodeDataModel>> getPinCodeData(
    Map<String, dynamic> params,
  );
}
