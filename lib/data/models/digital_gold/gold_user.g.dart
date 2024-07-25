// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gold_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoldUser _$GoldUserFromJson(Map<String, dynamic> json) => GoldUser(
      userId: json['userId'] as int,
      fullName: json['fullName'] as String,
      emailId: json['emailId'] as String,
      mobileNumber: json['mobileNumber'] as String,
      goldBalance: (json['goldBalance'] as num).toDouble(),
      silverBalance: (json['silverBalance'] as num).toDouble(),
      transactionalGoldBalance:
          (json['transactionalGoldBalance'] as num).toDouble(),
      transactionalSilverBalance:
          (json['transactionalSilverBalance'] as num).toDouble(),
      totalGoldInvestment: (json['totalGoldInvestment'] as num).toDouble(),
      totalSilverInvestment: (json['totalSilverInvestment'] as num).toDouble(),
      state: DGUserState.fromJson(json['state'] as Map<String, dynamic>),
      userBankDetails: json['userBankDetails'] == null
          ? null
          : GoldUserBankDetails.fromJson(
              json['userBankDetails'] as Map<String, dynamic>),
      cityId: json['cityId'] as String?,
      pincode: json['pincode'] as String?,
      dob: json['dob'] as String?,
      kycStatus: json['kycStatus'] as String?,
      kycRequired: json['kycRequired'] as bool,
      isTncAccepted: json['isTncAccepted'] as bool,
      isValidated: json['isValidated'] as bool,
      isActive: json['isActive'] as bool,
      isBankDetailsValidated: json['isBankDetailsValidated'] as bool,
      isMobileNumberVerified: json['isMobileNumberVerified'] as bool,
    );

Map<String, dynamic> _$GoldUserToJson(GoldUser instance) => <String, dynamic>{
      'userId': instance.userId,
      'fullName': instance.fullName,
      'emailId': instance.emailId,
      'mobileNumber': instance.mobileNumber,
      'goldBalance': instance.goldBalance,
      'silverBalance': instance.silverBalance,
      'transactionalGoldBalance': instance.transactionalGoldBalance,
      'transactionalSilverBalance': instance.transactionalSilverBalance,
      'totalGoldInvestment': instance.totalGoldInvestment,
      'totalSilverInvestment': instance.totalSilverInvestment,
      'state': instance.state,
      'userBankDetails': instance.userBankDetails,
      'cityId': instance.cityId,
      'pincode': instance.pincode,
      'dob': instance.dob,
      'kycStatus': instance.kycStatus,
      'kycRequired': instance.kycRequired,
      'isTncAccepted': instance.isTncAccepted,
      'isValidated': instance.isValidated,
      'isActive': instance.isActive,
      'isBankDetailsValidated': instance.isBankDetailsValidated,
      'isMobileNumberVerified': instance.isMobileNumberVerified,
    };

GoldUserBankDetails _$GoldUserBankDetailsFromJson(Map<String, dynamic> json) =>
    GoldUserBankDetails(
      id: json['id'] as int,
      accountNumber: json['accountNumber'] as String,
      accountHolderName: json['accountHolderName'] as String,
      ifscCode: json['ifscCode'] as String,
      isValidated: json['isValidated'] as bool,
      userBankId: json['userBankId'] as String,
      bankId: json['bankId'] as String?,
      bankName: json['bankName'] as String?,
      branchName: json['branchName'] as String?,
      isPrimary: json['isPrimary'] as bool,
      isActive: json['isActive'] as bool,
    );

Map<String, dynamic> _$GoldUserBankDetailsToJson(
        GoldUserBankDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'accountNumber': instance.accountNumber,
      'accountHolderName': instance.accountHolderName,
      'ifscCode': instance.ifscCode,
      'isValidated': instance.isValidated,
      'userBankId': instance.userBankId,
      'bankId': instance.bankId,
      'bankName': instance.bankName,
      'branchName': instance.branchName,
      'isPrimary': instance.isPrimary,
      'isActive': instance.isActive,
    };
