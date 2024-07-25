import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_bank_details_model.g.dart';

@JsonSerializable()
class UserBank extends Equatable {
  //  "id": 66,
  //             "accountType": {
  //                 "id": 1,
  //                 "type": "Savings",
  //                 "displayType": "SAVINGS",
  //                 "code": "savings",
  //                 "isActive": true
  //             },
  //             "accountHolderName": "Shashank S Mayya",
  //             "accountNumber": "919482249819",
  //             "bankName": "PAYTM PAYMENTS BANK LTD",
  //             "branchName": "Noida Branch",
  //             "ifscCode": "PYTM0123456",
  //             "isPrimaryAccount": true,
  //             "isActive": true,
  //             "isDeleted": false,
  //             "isBankVerified": false,
  //             "frsBankReferenceId": null,
  //             "fpBankId": null,
  //             "bankStatus": null,
  //             "referenceNo": null,
  //             "beneficiaryName": null

  final int id;
  final UserBankAccountType accountType;
  final String accountHolderName;
  final String accountNumber;
  final String bankName;
  final String branchName;
  final String ifscCode;
  final bool isPrimaryAccount;
  final bool isActive;
  final bool isDeleted;
  final bool isBankVerified;
  final String? frsBankReferenceId;
  final int? fpBankId;
  final bool isValidated;
  final String? augmontUserBankId;
  final int? augmontBankId;
  final int? mandateId;
  final String? imageUrl;

  String get maskedBankAccountNumber =>
      'XXXX ${accountNumber.substring(accountNumber.length - 4)}';

  const UserBank({
    required this.id,
    required this.accountType,
    required this.accountHolderName,
    required this.accountNumber,
    required this.bankName,
    required this.branchName,
    required this.ifscCode,
    required this.isPrimaryAccount,
    required this.isActive,
    required this.isDeleted,
    required this.isBankVerified,
    this.frsBankReferenceId,
    this.fpBankId,
    required this.isValidated,
    this.augmontUserBankId,
    this.augmontBankId,
    this.mandateId,
    this.imageUrl,
  });

  //copy With isPrimaryAccount

  UserBank copyWith({
    bool? isPrimaryAccount,
    String? ifscCode,
    int? mandateId,
    String? branchName,
  }) {
    return UserBank(
      id: id,
      accountType: accountType,
      accountHolderName: accountHolderName,
      accountNumber: accountNumber,
      bankName: bankName,
      branchName: branchName ?? this.branchName,
      ifscCode: ifscCode ?? this.ifscCode,
      isPrimaryAccount: isPrimaryAccount ?? this.isPrimaryAccount,
      isActive: isActive,
      isDeleted: isDeleted,
      isBankVerified: isBankVerified,
      frsBankReferenceId: frsBankReferenceId,
      fpBankId: fpBankId,
      isValidated: isValidated,
      augmontUserBankId: augmontUserBankId,
      augmontBankId: augmontBankId,
      mandateId: mandateId ?? this.mandateId,
      imageUrl: imageUrl,
    );
  }

  factory UserBank.fromJson(Map<String, dynamic> json) =>
      _$UserBankFromJson(json);

  Map<String, dynamic> toJson() => _$UserBankToJson(this);

  @override
  List<Object?> get props =>
      [id, accountNumber, accountHolderName, ifscCode, mandateId];
}

@JsonSerializable()
class UserBankAccountType {
  //  "id": 1,
  //             "type": "Savings",
  //             "displayType": "SAVINGS",
  //             "code": "savings",
  //             "isActive": true

  final int id;
  final String type;
  final String displayType;
  final String code;
  final bool isActive;

  UserBankAccountType({
    required this.id,
    required this.type,
    required this.displayType,
    required this.code,
    required this.isActive,
  });

  factory UserBankAccountType.fromJson(Map<String, dynamic> json) =>
      _$UserBankAccountTypeFromJson(json);

  Map<String, dynamic> toJson() => _$UserBankAccountTypeToJson(this);
}
