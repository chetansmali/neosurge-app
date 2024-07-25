// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_bank_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBank _$UserBankFromJson(Map<String, dynamic> json) => UserBank(
      id: json['id'] as int,
      accountType: UserBankAccountType.fromJson(
          json['accountType'] as Map<String, dynamic>),
      accountHolderName: json['accountHolderName'] as String,
      accountNumber: json['accountNumber'] as String,
      bankName: json['bankName'] as String,
      branchName: json['branchName'] as String,
      ifscCode: json['ifscCode'] as String,
      isPrimaryAccount: json['isPrimaryAccount'] as bool,
      isActive: json['isActive'] as bool,
      isDeleted: json['isDeleted'] as bool,
      isBankVerified: json['isBankVerified'] as bool,
      frsBankReferenceId: json['frsBankReferenceId'] as String?,
      fpBankId: json['fpBankId'] as int?,
      isValidated: json['isValidated'] as bool,
      augmontUserBankId: json['augmontUserBankId'] as String?,
      augmontBankId: json['augmontBankId'] as int?,
      mandateId: json['mandateId'] as int?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$UserBankToJson(UserBank instance) => <String, dynamic>{
      'id': instance.id,
      'accountType': instance.accountType,
      'accountHolderName': instance.accountHolderName,
      'accountNumber': instance.accountNumber,
      'bankName': instance.bankName,
      'branchName': instance.branchName,
      'ifscCode': instance.ifscCode,
      'isPrimaryAccount': instance.isPrimaryAccount,
      'isActive': instance.isActive,
      'isDeleted': instance.isDeleted,
      'isBankVerified': instance.isBankVerified,
      'frsBankReferenceId': instance.frsBankReferenceId,
      'fpBankId': instance.fpBankId,
      'isValidated': instance.isValidated,
      'augmontUserBankId': instance.augmontUserBankId,
      'augmontBankId': instance.augmontBankId,
      'mandateId': instance.mandateId,
      'imageUrl': instance.imageUrl,
    };

UserBankAccountType _$UserBankAccountTypeFromJson(Map<String, dynamic> json) =>
    UserBankAccountType(
      id: json['id'] as int,
      type: json['type'] as String,
      displayType: json['displayType'] as String,
      code: json['code'] as String,
      isActive: json['isActive'] as bool,
    );

Map<String, dynamic> _$UserBankAccountTypeToJson(
        UserBankAccountType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'displayType': instance.displayType,
      'code': instance.code,
      'isActive': instance.isActive,
    };
