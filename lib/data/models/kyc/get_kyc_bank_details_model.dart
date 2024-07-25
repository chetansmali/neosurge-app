import 'package:json_annotation/json_annotation.dart';

import '../../../constants/dropdown_constants.dart';

part 'get_kyc_bank_details_model.g.dart';

@JsonSerializable()
class GetKycBankDetailsModel {
  final String accountHolderName;
  final String accountNumber;
  final String bankName;
  final String branchName;
  final String ifscCode;
  final DropDownItem? accountType;
  final bool isPrimaryAccount;

  GetKycBankDetailsModel({
    required this.accountHolderName,
    required this.accountNumber,
    required this.bankName,
    required this.branchName,
    required this.ifscCode,
    required this.accountType,
    required this.isPrimaryAccount,
  });

  factory GetKycBankDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$GetKycBankDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetKycBankDetailsModelToJson(this);
}
