import 'package:json_annotation/json_annotation.dart';

part 'initiate_loan_closure_details.g.dart';

@JsonSerializable()
class InitiateLoanClosureDetails {
  final int outstanding;
  final bool loanClosable;

  InitiateLoanClosureDetails({
    required this.loanClosable,
    required this.outstanding,
  });

  factory InitiateLoanClosureDetails.fromJson(Map<String, dynamic> json) =>
      _$InitiateLoanClosureDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$InitiateLoanClosureDetailsToJson(this);
}
