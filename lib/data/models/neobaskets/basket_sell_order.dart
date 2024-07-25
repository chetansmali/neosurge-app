import 'package:json_annotation/json_annotation.dart';

part 'basket_sell_order.g.dart';

@JsonSerializable()
class BasketSellOrder {
  final String? basketName;
  final String orderRef;
  final String? date;
  final String? type;
  final double? amount;
  final String? status;

  const BasketSellOrder({
    required this.basketName,
    required this.orderRef,
    required this.date,
    required this.type,
    required this.amount,
    required this.status,
  });

  Map<String, dynamic> toJson() => _$BasketSellOrderToJson(this);

  factory BasketSellOrder.fromJson(Map<String, dynamic> json) =>
      _$BasketSellOrderFromJson(json);

  static List<BasketSellOrder> listFromJson(List<dynamic> json) =>
      json.map((e) => BasketSellOrder.fromJson(e)).toList();
}
