import 'package:json_annotation/json_annotation.dart';

part 'basket_buy_order.g.dart';

@JsonSerializable()
class BasketBuyOrder {
  final String? basketName;
  final String? orderRef;
  final String? date;
  final String? type;
  final double? amount;
  final String? status;

  const BasketBuyOrder({
    required this.basketName,
    required this.orderRef,
    required this.date,
    required this.type,
    required this.amount,
    required this.status,
  });

  Map<String, dynamic> toJson() => _$BasketBuyOrderToJson(this);

  factory BasketBuyOrder.fromJson(Map<String, dynamic> json) =>
      _$BasketBuyOrderFromJson(json);

  static List<BasketBuyOrder> listFromJson(List<dynamic> json) =>
      json.map((e) => BasketBuyOrder.fromJson(e)).toList();
}
