import 'package:json_annotation/json_annotation.dart';

part 'bank_details_by_ifsc_model.g.dart';

@JsonSerializable()
class BankDetailsByIfscModel {
  @JsonKey(name: 'ifsc_code')
  final String ifscCode;
  @JsonKey(name: 'micr_code')
  final String? micrCode;
  @JsonKey(name: 'branch_name')
  final String branchName;
  @JsonKey(name: 'branch_address')
  final String branchAddress;
  @JsonKey(name: 'bank_name')
  final String bankName;
  final String? contact;
  final String city;
  final String district;
  final String state;

  BankDetailsByIfscModel({
    required this.ifscCode,
    this.micrCode,
    required this.branchName,
    required this.branchAddress,
    required this.bankName,
    this.contact,
    required this.city,
    required this.district,
    required this.state,
  });

  factory BankDetailsByIfscModel.fromJson(Map<String, dynamic> json) =>
      _$BankDetailsByIfscModelFromJson(json);

  Map<String, dynamic> toJson() => _$BankDetailsByIfscModelToJson(this);
}
