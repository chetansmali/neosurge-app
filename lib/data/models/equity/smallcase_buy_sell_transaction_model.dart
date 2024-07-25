import 'package:json_annotation/json_annotation.dart';

part 'smallcase_buy_sell_transaction_model.g.dart';

@JsonSerializable()
class SmallCaseBSTransaction {
  Data data;
  String broker;
  String smallcaseAuthToken;
  String transactionId;

  SmallCaseBSTransaction({
    required this.data,
    required this.broker,
    required this.smallcaseAuthToken,
    required this.transactionId,
  });

  factory SmallCaseBSTransaction.fromJson(Map<String, dynamic> json) =>
      _$SmallCaseBSTransactionFromJson(json);

  Map<String, dynamic> toJson() => _$SmallCaseBSTransactionToJson(this);
}

@JsonSerializable()
class Data {
  List<Batch> batches;

  Data({required this.batches});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Batch {
  int? filled;
  String variety;
  double? buyAmount;
  double? sellAmount;
  List<Order> orders;
  List<dynamic> unplaced;
  String batchId;
  String broker;
  int quantity;
  String status;
  String completedDate;
  String transactionId;

  Batch({
    required this.filled,
    required this.variety,
    required this.buyAmount,
    required this.sellAmount,
    required this.orders,
    required this.unplaced,
    required this.batchId,
    required this.broker,
    required this.quantity,
    required this.status,
    required this.completedDate,
    required this.transactionId,
  });

  factory Batch.fromJson(Map<String, dynamic> json) => _$BatchFromJson(json);

  Map<String, dynamic> toJson() => _$BatchToJson(this);
}


@JsonSerializable()
class Order {
  String orderType;
  String product;
  double? price;
  String exchange;
  double? averagePrice;
  String status;
  int? filledQuantity;
  String statusMessage;
  int? quantity;
  String orderTimestamp;
  String transactionType;
  double? triggerPrice;
  String tradingsymbol;
  String exchangeOrderId;
  String errorCode;

  Order({
    required this.orderType,
    required this.product,
    required this.price,
    required this.exchange,
    required this.averagePrice,
    required this.status,
    required this.filledQuantity,
    required this.statusMessage,
    required this.quantity,
    required this.orderTimestamp,
    required this.transactionType,
    required this.triggerPrice,
    required this.tradingsymbol,
    required this.exchangeOrderId,
    required this.errorCode,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}




