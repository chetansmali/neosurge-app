import 'package:json_annotation/json_annotation.dart';

part 'get_loan_data_response.g.dart';

@JsonSerializable()
class GetLoanDataResponse {
  final String? loanType;
  final String? startDate;
  final String? accountNumber;
  final String? lenderName;
  final double? sanctionedAmount;
  final double? outstanding;
  final double? interest;
  final int? tenure;
  final bool? isSecured;
  final String? loanStatus;
  final double? emi;
  final GetLoanDataResponsePayments? payments;

  GetLoanDataResponse({
    this.loanType,
    this.startDate,
    this.accountNumber,
    this.lenderName,
    this.sanctionedAmount,
    this.outstanding,
    this.interest,
    this.tenure,
    this.isSecured,
    this.loanStatus,
    this.emi,
    this.payments,
  });

  factory GetLoanDataResponse.fromJson(Map<String, dynamic> json) =>
      _$GetLoanDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetLoanDataResponseToJson(this);
}

@JsonSerializable()
class GetLoanDataResponsePayments {
  int? totalPayments;
  int? ontimePayments;
  int? delayedPayments;

  GetLoanDataResponsePayments({
    this.totalPayments,
    this.ontimePayments,
    this.delayedPayments,
  });

  factory GetLoanDataResponsePayments.fromJson(Map<String, dynamic> json) =>
      _$GetLoanDataResponsePaymentsFromJson(json);

  Map<String, dynamic> toJson() => _$GetLoanDataResponsePaymentsToJson(this);
}
