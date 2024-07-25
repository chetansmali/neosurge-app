import 'package:json_annotation/json_annotation.dart';
part 'equity_orders_model.g.dart';

@JsonSerializable()
class EquityOrderModel {
  final String? transactionId;
  final String? smallcaseAuthId;
  final String? creationMonthYear;
  final int? creationDay;
  final String? exchangeOrderId;
  final String? status;
  final String? orderType;
  final String? product;
  final String? exchange;
  final String? broker;
  final int? quantity;
  final String? tradingSymbol;
  final String? companyName;
  final String? icon;
  final String? transactionType;
  final int? filledQuantity;
  final double? averagePrice;
  final DateTime? txnCompletedDateTime;
  final String? batchId;
  final String? type;
  final String? errorCode;
  final String? statusMessage;

  EquityOrderModel({
    required this.transactionId,
    required this.smallcaseAuthId,
    required this.creationMonthYear,
    required this.creationDay,
    required this.exchangeOrderId,
    required this.status,
    required this.orderType,
    required this.product,
    required this.exchange,
    required this.broker,
    required this.quantity,
    required this.tradingSymbol,
    required this.companyName,
    required this.icon,
    required this.transactionType,
    required this.filledQuantity,
    required this.averagePrice,
    required this.txnCompletedDateTime,
    required this.batchId,
    required this.type,
    required this.errorCode,
    required this.statusMessage,
  });
  factory EquityOrderModel.fromJson(Map<String, dynamic> json) =>
      _$EquityOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$EquityOrderModelToJson(this);

  static List<EquityOrderModel> listFromJson(List<dynamic> json) =>
      json.map((e) => EquityOrderModel.fromJson(e)).toList();
}
