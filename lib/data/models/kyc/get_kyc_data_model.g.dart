// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_kyc_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetKycDataModel _$GetKycDataModelFromJson(Map<String, dynamic> json) =>
    GetKycDataModel(
      panNum: json['panNum'] as String,
      panFullName: json['panFullName'] as String?,
      aadhaarNum: json['aadhaarNum'] as String?,
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      adressProofType: json['adressProofType'] == null
          ? null
          : DropDownItem.fromJson(
              json['adressProofType'] as Map<String, dynamic>),
      addressProofNum: json['addressProofNum'] as String?,
      addressProofIssueDate: json['addressProofIssueDate'] as String?,
      addressProofExpiryDate: json['addressProofExpiryDate'] as String?,
      fpKcyId: json['fpKcyId'] as String?,
      fpKycStatus: json['fpKycStatus'] as String?,
      fpEsignId: json['fpEsignId'] as String?,
      fpEsignStatus: json['fpEsignStatus'] as String?,
      initialKycStatus: json['initialKycStatus'] as bool,
      userKycFilesData: json['userKycFilesData'] == null
          ? null
          : UserKycFilesData.fromJson(
              json['userKycFilesData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetKycDataModelToJson(GetKycDataModel instance) =>
    <String, dynamic>{
      'panNum': instance.panNum,
      'panFullName': instance.panFullName,
      'aadhaarNum': instance.aadhaarNum,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'adressProofType': instance.adressProofType,
      'addressProofNum': instance.addressProofNum,
      'addressProofIssueDate': instance.addressProofIssueDate,
      'addressProofExpiryDate': instance.addressProofExpiryDate,
      'fpKcyId': instance.fpKcyId,
      'fpKycStatus': instance.fpKycStatus,
      'fpEsignId': instance.fpEsignId,
      'fpEsignStatus': instance.fpEsignStatus,
      'initialKycStatus': instance.initialKycStatus,
      'userKycFilesData': instance.userKycFilesData,
    };

UserKycFilesData _$UserKycFilesDataFromJson(Map<String, dynamic> json) =>
    UserKycFilesData(
      panFpId: json['panFpId'] as String?,
      panPublicUrl: json['panPublicUrl'] as String?,
      addressProofFrontFpId: json['addressProofFrontFpId'] as String?,
      addressProofFrontPublicUrl: json['addressProofFrontPublicUrl'] as String?,
      addressProofBackFpId: json['addressProofBackFpId'] as String?,
      addressProofBackPublicUrl: json['addressProofBackPublicUrl'] as String?,
      userImageFpId: json['userImageFpId'] as String?,
      userImagePublicUrl: json['userImagePublicUrl'] as String?,
      userSignatureFpId: json['userSignatureFpId'] as String?,
      userSignaturePublicUrl: json['userSignaturePublicUrl'] as String?,
      videoFpId: json['videoFpId'] as String?,
      videoPublicUrl: json['videoPublicUrl'] as String?,
      cancelledChequeFpId: json['cancelledChequeFpId'] as String?,
      cancelledChequePublicUrl: json['cancelledChequePublicUrl'] as String?,
    );

Map<String, dynamic> _$UserKycFilesDataToJson(UserKycFilesData instance) =>
    <String, dynamic>{
      'panFpId': instance.panFpId,
      'panPublicUrl': instance.panPublicUrl,
      'addressProofFrontFpId': instance.addressProofFrontFpId,
      'addressProofFrontPublicUrl': instance.addressProofFrontPublicUrl,
      'addressProofBackFpId': instance.addressProofBackFpId,
      'addressProofBackPublicUrl': instance.addressProofBackPublicUrl,
      'userImageFpId': instance.userImageFpId,
      'userImagePublicUrl': instance.userImagePublicUrl,
      'userSignatureFpId': instance.userSignatureFpId,
      'userSignaturePublicUrl': instance.userSignaturePublicUrl,
      'videoFpId': instance.videoFpId,
      'videoPublicUrl': instance.videoPublicUrl,
      'cancelledChequeFpId': instance.cancelledChequeFpId,
      'cancelledChequePublicUrl': instance.cancelledChequePublicUrl,
    };
