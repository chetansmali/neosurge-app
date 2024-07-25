import 'package:json_annotation/json_annotation.dart';
part 'portfolio_positions.g.dart';

@JsonSerializable()
class PortfolioPositionModel {
  String smallcaseAuthId;
  List<Position> positions;

  PortfolioPositionModel({
    required this.smallcaseAuthId,
    required this.positions,
  });
  factory PortfolioPositionModel.fromJson(Map<String, dynamic> json) =>
      _$PortfolioPositionModelFromJson(json);

  Map<String, dynamic> toJson() => _$PortfolioPositionModelToJson(this);
}

@JsonSerializable()
class Position {
  PositionKeyObject positionKeyObject;
  String transactionId;
  String smallcaseAuthId;
  String creationMonthYear;
  int creationDay;
  dynamic exchangeOrderId;
  String status;
  String orderType;
  String product;
  String exchange;
  String broker;
  int quantity;
  String tradingSymbol;
  String? companyName;
  String? icon;
  String? transactionType;
  int? filledQuantity;
  double averagePrice;
  DateTime txnCompletedDateTime;
  String? batchId;
  String? type;
  dynamic errorCode;
  String? statusMessage;

  Position({
    required this.positionKeyObject,
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
  factory Position.fromJson(Map<String, dynamic> json) =>
      _$PositionFromJson(json);

  Map<String, dynamic> toJson() => _$PositionToJson(this);
}

@JsonSerializable()
class PositionKeyObject {
  String symbol;
  String status;

  PositionKeyObject({
    required this.symbol,
    required this.status,
  });
  factory PositionKeyObject.fromJson(Map<String, dynamic> json) =>
      _$PositionKeyObjectFromJson(json);

  Map<String, dynamic> toJson() => _$PositionKeyObjectToJson(this);
}
