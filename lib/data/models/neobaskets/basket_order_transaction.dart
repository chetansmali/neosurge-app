import 'package:json_annotation/json_annotation.dart';

part 'basket_order_transaction.g.dart';

@JsonSerializable()
class BasketOrderTransactionDetail {
  final String? basketName;
  final String? transactionType;
  final String? date;
  final String? type;
  final double amount;
  final int fundsCount;
  final String? orderRef;
  final List<Fund> funds;

  const BasketOrderTransactionDetail({
    required this.basketName,
    required this.transactionType,
    required this.date,
    required this.type,
    required this.amount,
    required this.fundsCount,
    required this.orderRef,
    required this.funds,
  });

  Map<String, dynamic> toJson() => _$BasketOrderTransactionDetailToJson(this);

  factory BasketOrderTransactionDetail.fromJson(Map<String, dynamic> json) =>
      _$BasketOrderTransactionDetailFromJson(json);

  static List<BasketOrderTransactionDetail> listFromJson(List<dynamic> json) =>
      json.map((e) => BasketOrderTransactionDetail.fromJson(e)).toList();
}

@JsonSerializable()
class Fund {
  final String name;
  final String transactionID;
  final double amount;
  final String status;
  final double? units;
  final double? nav;

  const Fund({
    required this.name,
    required this.transactionID,
    required this.amount,
    required this.status,
    required this.units,
    required this.nav,
  });

  Map<String, dynamic> toJson() => _$FundToJson(this);

  factory Fund.fromJson(Map<String, dynamic> json) => _$FundFromJson(json);

  static List<Fund> listFromJson(List<dynamic> json) =>
      json.map((e) => Fund.fromJson(e)).toList();
}
