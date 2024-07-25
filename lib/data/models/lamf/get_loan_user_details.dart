import 'package:json_annotation/json_annotation.dart';
part 'get_loan_user_details.g.dart';

@JsonSerializable()
class GetLoanUserDetails {
  int? id;
  int? userID;
  bool? loansImported;
  bool? mfImported;
  bool? loanInitiated;
  bool? creditPulled;
  double? loanPercentage;
  @JsonKey(name: 'credit_limit')
  double? creditLimit;

  GetLoanUserDetails({
    this.id,
    this.userID,
    this.loansImported,
    this.mfImported,
    this.loanInitiated,
    this.creditPulled,
    this.loanPercentage,
    this.creditLimit,
  });

  // Method to create a User instance from a map (e.g., from JSON)
  factory GetLoanUserDetails.fromJson(Map<String, dynamic> json) =>
      _$GetLoanUserDetailsFromJson(json);

  // Method to convert User instance to a map
  Map<String, dynamic> toJson() => _$GetLoanUserDetailsToJson(this);
}
