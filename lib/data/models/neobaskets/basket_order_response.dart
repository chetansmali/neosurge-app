import 'package:json_annotation/json_annotation.dart';
part 'basket_order_response.g.dart';

@JsonSerializable()
class BasketOrderResponse {
  final String? status;
  final String? basketName;
  final String? orderType;
  final double? amount;
  final String? message;
  final String orderRef;
  final int? monthlyInvDate;
  final List<Fund> funds;

  BasketOrderResponse({
    required this.status,
    required this.basketName,
    required this.orderType,
    required this.amount,
    required this.message,
    required this.orderRef,
    required this.funds,
    required this.monthlyInvDate,
  });

  factory BasketOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$BasketOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BasketOrderResponseToJson(this);
}

@JsonSerializable()
class Fund {
  final String fundName;
  final double amount;

  Fund({
    required this.fundName,
    required this.amount,
  });

  factory Fund.fromJson(Map<String, dynamic> json) => _$FundFromJson(json);

  Map<String, dynamic> toJson() => _$FundToJson(this);
}
