import 'package:json_annotation/json_annotation.dart';

part 'basket_buy_transaction.g.dart';

@JsonSerializable()
class BasketBuyTransaction {
  final String? orderRef;
  final String? date;
  final double? amount;
  final String? type;

  BasketBuyTransaction({
    required this.orderRef,
    required this.date,
    required this.amount,
    required this.type,
  });

  factory BasketBuyTransaction.fromJson(Map<String, dynamic> json) =>
      _$BasketBuyTransactionFromJson(json);

  Map<String, dynamic> toJson() => _$BasketBuyTransactionToJson(this);

  static List<BasketBuyTransaction> listFromJson(List<dynamic> json) =>
      json.map((e) => BasketBuyTransaction.fromJson(e)).toList();
}
