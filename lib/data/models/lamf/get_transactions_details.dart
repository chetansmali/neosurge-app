import 'package:json_annotation/json_annotation.dart';

part 'get_transactions_details.g.dart';

@JsonSerializable()
class GetTransactionsDetails {
  final Transaction transaction;
  GetTransactionsDetails(this.transaction);

  factory GetTransactionsDetails.fromJson(Map<String, dynamic> json) =>
      _$GetTransactionsDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$GetTransactionsDetailsToJson(this);
}

@JsonSerializable()
class Transaction extends GetTransactionsDetails {
  final int amount;
  final String date;
  final String description;

  Transaction(
    super.transaction, {
    required this.amount,
    required this.date,
    required this.description,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}
