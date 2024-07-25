// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_bank_details_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadBankDetailsParams _$UploadBankDetailsParamsFromJson(
        Map<String, dynamic> json) =>
    UploadBankDetailsParams(
      id: json['id'] as int?,
      accountHolderName: json['accountHolderName'] as String,
      accountNumber: json['accountNumber'] as String,
      bankName: json['bankName'] as String,
      branchName: json['branchName'] as String,
      ifscCode: json['ifscCode'] as String,
      accountType: json['accountType'] as int,
      isPrimaryAccount: json['isPrimaryAccount'] as bool,
    );

Map<String, dynamic> _$UploadBankDetailsParamsToJson(
    UploadBankDetailsParams instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['accountHolderName'] = instance.accountHolderName;
  val['accountNumber'] = instance.accountNumber;
  val['bankName'] = instance.bankName;
  val['branchName'] = instance.branchName;
  val['ifscCode'] = instance.ifscCode;
  val['accountType'] = instance.accountType;
  val['isPrimaryAccount'] = instance.isPrimaryAccount;
  return val;
}
