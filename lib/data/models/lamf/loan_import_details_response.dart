import 'package:json_annotation/json_annotation.dart';

part 'loan_import_details_response.g.dart';

@JsonSerializable()
class LoanImportDetailsModel {
  String? firstName;
  String? lastName;
  String? dob;
  String? mobile;
  String? pan;
  String? email;

  LoanImportDetailsModel({
    this.firstName,
    this.lastName,
    this.dob,
    this.mobile,
    this.pan,
    this.email,
  });

  factory LoanImportDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$LoanImportDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoanImportDetailsModelToJson(this);
}
