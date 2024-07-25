import 'package:json_annotation/json_annotation.dart';

part 'initiate_loan_import_params.g.dart';

@JsonSerializable()
class GetInitiateLoanImportsParams {
  String firstName;
  String lastName;
  String dob;
  String mobile;
  String pan;
  String email;

  GetInitiateLoanImportsParams({
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.mobile,
    required this.pan,
    required this.email,
  });

  factory GetInitiateLoanImportsParams.fromJson(Map<String, dynamic> json) =>
      _$GetInitiateLoanImportsParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetInitiateLoanImportsParamsToJson(this);
}
