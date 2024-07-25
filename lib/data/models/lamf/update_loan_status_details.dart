import 'package:json_annotation/json_annotation.dart';

part 'update_loan_status_details.g.dart';

@JsonSerializable()
class UpdateLoanStatusDetails {
  final String message;
  final String status;
  UpdateLoanStatusDetails({required this.message, required this.status});

  factory UpdateLoanStatusDetails.fromJson(Map<String, dynamic> json) =>
      _$UpdateLoanStatusDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateLoanStatusDetailsToJson(this);
}
