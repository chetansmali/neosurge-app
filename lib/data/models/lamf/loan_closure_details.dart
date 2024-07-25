import 'package:json_annotation/json_annotation.dart';

part 'loan_closure_details.g.dart';

@JsonSerializable()
class LoanClosureDetails {
  final String status;
  final String message;
  final int amount;
  LoanClosureDetails(this.status, this.message, this.amount);

  factory LoanClosureDetails.fromJson(Map<String, dynamic> json) =>
      _$LoanClosureDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$LoanClosureDetailsToJson(this);
}
