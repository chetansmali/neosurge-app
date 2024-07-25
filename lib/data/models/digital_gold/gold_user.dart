import 'package:json_annotation/json_annotation.dart';

import '../user/address_details_model.dart';

part 'gold_user.g.dart';

@JsonSerializable()
class GoldUser {
  final int userId;
  final String fullName;
  final String emailId;
  final String mobileNumber;
  final double goldBalance;
  final double silverBalance;
  final double transactionalGoldBalance;
  final double transactionalSilverBalance;
  final double totalGoldInvestment;
  final double totalSilverInvestment;
  final DGUserState state;
  final GoldUserBankDetails? userBankDetails;
  final String? cityId;
  final String? pincode;
  final String? dob;
  final String? kycStatus;
  final bool kycRequired;
  final bool isTncAccepted;
  final bool isValidated;
  final bool isActive;
  final bool isBankDetailsValidated;
  final bool isMobileNumberVerified;

  GoldUser({
    required this.userId,
    required this.fullName,
    required this.emailId,
    required this.mobileNumber,
    required this.goldBalance,
    required this.silverBalance,
    required this.transactionalGoldBalance,
    required this.transactionalSilverBalance,
    required this.totalGoldInvestment,
    required this.totalSilverInvestment,
    required this.state,
    this.userBankDetails,
    this.cityId,
    this.pincode,
    this.dob,
    this.kycStatus,
    required this.kycRequired,
    required this.isTncAccepted,
    required this.isValidated,
    required this.isActive,
    required this.isBankDetailsValidated,
    required this.isMobileNumberVerified,
  });

  factory GoldUser.fromJson(Map<String, dynamic> json) =>
      _$GoldUserFromJson(json);

  Map<String, dynamic> toJson() => _$GoldUserToJson(this);
}

@JsonSerializable()
class GoldUserBankDetails {
  final int id;
  final String accountNumber;
  final String accountHolderName;
  final String ifscCode;
  final bool isValidated;
  final String userBankId;
  final String? bankId;
  final String? bankName;
  final String? branchName;
  final bool isPrimary;
  final bool isActive;

  GoldUserBankDetails({
    required this.id,
    required this.accountNumber,
    required this.accountHolderName,
    required this.ifscCode,
    required this.isValidated,
    required this.userBankId,
    this.bankId,
    this.bankName,
    this.branchName,
    required this.isPrimary,
    required this.isActive,
  });

  factory GoldUserBankDetails.fromJson(Map<String, dynamic> json) =>
      _$GoldUserBankDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$GoldUserBankDetailsToJson(this);
}
