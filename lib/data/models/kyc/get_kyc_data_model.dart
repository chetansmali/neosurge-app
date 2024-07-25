import 'package:json_annotation/json_annotation.dart';

import '../../../constants/dropdown_constants.dart';

part 'get_kyc_data_model.g.dart';

@JsonSerializable()
class GetKycDataModel {
  final String panNum;
  final String? panFullName;
  final String? aadhaarNum;
  final DateTime? dateOfBirth;

  final DropDownItem? adressProofType;
  final String? addressProofNum;
  final String? addressProofIssueDate;
  final String? addressProofExpiryDate;
  final String? fpKcyId;
  final String? fpKycStatus;
  final String? fpEsignId;
  final String? fpEsignStatus;
  final bool initialKycStatus;
  final UserKycFilesData? userKycFilesData;

  GetKycDataModel({
    required this.panNum,
    this.panFullName,
    this.aadhaarNum,
    this.dateOfBirth,
    this.adressProofType,
    this.addressProofNum,
    this.addressProofIssueDate,
    this.addressProofExpiryDate,
    this.fpKcyId,
    this.fpKycStatus,
    this.fpEsignId,
    this.fpEsignStatus,
    required this.initialKycStatus,
    this.userKycFilesData,
  });

  factory GetKycDataModel.fromJson(Map<String, dynamic> json) =>
      _$GetKycDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetKycDataModelToJson(this);
}

@JsonSerializable()
class UserKycFilesData {
  final String? panFpId;
  final String? panPublicUrl;
  final String? addressProofFrontFpId;
  final String? addressProofFrontPublicUrl;
  final String? addressProofBackFpId;
  final String? addressProofBackPublicUrl;
  final String? userImageFpId;
  final String? userImagePublicUrl;
  final String? userSignatureFpId;
  final String? userSignaturePublicUrl;
  final String? videoFpId;
  final String? videoPublicUrl;
  final String? cancelledChequeFpId;
  final String? cancelledChequePublicUrl;

  UserKycFilesData({
    this.panFpId,
    this.panPublicUrl,
    this.addressProofFrontFpId,
    this.addressProofFrontPublicUrl,
    this.addressProofBackFpId,
    this.addressProofBackPublicUrl,
    this.userImageFpId,
    this.userImagePublicUrl,
    this.userSignatureFpId,
    this.userSignaturePublicUrl,
    this.videoFpId,
    this.videoPublicUrl,
    this.cancelledChequeFpId,
    this.cancelledChequePublicUrl,
  });

  factory UserKycFilesData.fromJson(Map<String, dynamic> json) =>
      _$UserKycFilesDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserKycFilesDataToJson(this);
}
