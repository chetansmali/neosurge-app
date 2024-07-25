import 'package:json_annotation/json_annotation.dart';

part 'get_loan_data_details.g.dart';

@JsonSerializable()
class GetLoanDataDetails {
  final double cashWithdrawn;
  final double cashAvailable;
  final double creditLimit;
  final int pledgedCount;
  List<Transaction> transactions;

  GetLoanDataDetails({
    required this.cashWithdrawn,
    required this.cashAvailable,
    required this.creditLimit,
    required this.pledgedCount,
    required this.transactions,
  });

  factory GetLoanDataDetails.fromJson(Map<String, dynamic> json) =>
      _$GetLoanDataDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$GetLoanDataDetailsToJson(this);
}

@JsonSerializable()
class Transaction {
  final String date;
  final double amount;
  final String description;
  Transaction(
      {required this.date, required this.amount, required this.description});

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}
