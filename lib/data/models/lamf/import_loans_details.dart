import 'package:json_annotation/json_annotation.dart';
part 'import_loans_details.g.dart';

@JsonSerializable()
class ImportLoansDetails {
  int userID;
  String activeLoans;
  String sanctionAmount;
  String amountPending;
  String totalEMI;
  String amountRepaid;

  ImportLoansDetails({
    required this.userID,
    required this.activeLoans,
    required this.sanctionAmount,
    required this.amountPending,
    required this.totalEMI,
    required this.amountRepaid,
  });

  factory ImportLoansDetails.fromJson(Map<String, dynamic> json) =>
      _$ImportLoansDetailsFromJson(json);

  // Method to convert User instance to a map
  Map<String, dynamic> toJson() => _$ImportLoansDetailsToJson(this);
}
