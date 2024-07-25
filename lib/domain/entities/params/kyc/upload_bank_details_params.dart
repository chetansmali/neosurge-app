import 'package:json_annotation/json_annotation.dart';

part 'upload_bank_details_params.g.dart';

@JsonSerializable(
  includeIfNull: false,
)
class UploadBankDetailsParams {
  ///[id] is the id of the user bank and used to update the existing bank ifscCode
  final int? id;
  final String accountHolderName;
  final String accountNumber;
  final String bankName;
  final String branchName;
  final String ifscCode;
  final int accountType;
  final bool isPrimaryAccount;

  UploadBankDetailsParams({
    this.id,
    required this.accountHolderName,
    required this.accountNumber,
    required this.bankName,
    required this.branchName,
    required this.ifscCode,
    required this.accountType,
    required this.isPrimaryAccount,
  });

  factory UploadBankDetailsParams.fromJson(Map<String, dynamic> json) =>
      _$UploadBankDetailsParamsFromJson(json);

  Map<String, dynamic> toJson() => _$UploadBankDetailsParamsToJson(this);
}
