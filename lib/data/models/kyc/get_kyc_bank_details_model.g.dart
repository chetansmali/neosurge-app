// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_kyc_bank_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetKycBankDetailsModel _$GetKycBankDetailsModelFromJson(
        Map<String, dynamic> json) =>
    GetKycBankDetailsModel(
      accountHolderName: json['accountHolderName'] as String,
      accountNumber: json['accountNumber'] as String,
      bankName: json['bankName'] as String,
      branchName: json['branchName'] as String,
      ifscCode: json['ifscCode'] as String,
      accountType: json['accountType'] == null
          ? null
          : DropDownItem.fromJson(json['accountType'] as Map<String, dynamic>),
      isPrimaryAccount: json['isPrimaryAccount'] as bool,
    );

Map<String, dynamic> _$GetKycBankDetailsModelToJson(
        GetKycBankDetailsModel instance) =>
    <String, dynamic>{
      'accountHolderName': instance.accountHolderName,
      'accountNumber': instance.accountNumber,
      'bankName': instance.bankName,
      'branchName': instance.branchName,
      'ifscCode': instance.ifscCode,
      'accountType': instance.accountType,
      'isPrimaryAccount': instance.isPrimaryAccount,
    };
