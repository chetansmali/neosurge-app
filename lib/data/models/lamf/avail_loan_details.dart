import 'package:json_annotation/json_annotation.dart';

part 'avail_loan_details.g.dart';

@JsonSerializable()
class AvailLoanDetails {
  final String interactionToken;

  AvailLoanDetails({required this.interactionToken});

  factory AvailLoanDetails.fromJson(Map<String, dynamic> json) =>
      _$AvailLoanDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$AvailLoanDetailsToJson(this);
}
