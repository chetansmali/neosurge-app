import 'package:json_annotation/json_annotation.dart';

part 'basket_sell_transaction.g.dart';

@JsonSerializable()
class BasketSellTransaction {
  final String orderRef;
  final String? date;
  final double? amount;

  BasketSellTransaction({
    required this.orderRef,
    required this.date,
    required this.amount,
  });

  factory BasketSellTransaction.fromJson(Map<String, dynamic> json) =>
      _$BasketSellTransactionFromJson(json);

  Map<String, dynamic> toJson() => _$BasketSellTransactionToJson(this);

  static List<BasketSellTransaction> listFromJson(List<dynamic> json) =>
      json.map((e) => BasketSellTransaction.fromJson(e)).toList();
}
