// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smallcase_buy_sell_transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SmallCaseBSTransaction _$SmallCaseBSTransactionFromJson(
        Map<String, dynamic> json) =>
    SmallCaseBSTransaction(
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
      broker: json['broker'] as String,
      smallcaseAuthToken: json['smallcaseAuthToken'] as String,
      transactionId: json['transactionId'] as String,
    );

Map<String, dynamic> _$SmallCaseBSTransactionToJson(
        SmallCaseBSTransaction instance) =>
    <String, dynamic>{
      'data': instance.data,
      'broker': instance.broker,
      'smallcaseAuthToken': instance.smallcaseAuthToken,
      'transactionId': instance.transactionId,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      batches: (json['batches'] as List<dynamic>)
          .map((e) => Batch.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'batches': instance.batches,
    };

Batch _$BatchFromJson(Map<String, dynamic> json) => Batch(
      filled: json['filled'] as int?,
      variety: json['variety'] as String,
      buyAmount: (json['buyAmount'] as num?)?.toDouble(),
      sellAmount: (json['sellAmount'] as num?)?.toDouble(),
      orders: (json['orders'] as List<dynamic>)
          .map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList(),
      unplaced: json['unplaced'] as List<dynamic>,
      batchId: json['batchId'] as String,
      broker: json['broker'] as String,
      quantity: json['quantity'] as int,
      status: json['status'] as String,
      completedDate: json['completedDate'] as String,
      transactionId: json['transactionId'] as String,
    );

Map<String, dynamic> _$BatchToJson(Batch instance) => <String, dynamic>{
      'filled': instance.filled,
      'variety': instance.variety,
      'buyAmount': instance.buyAmount,
      'sellAmount': instance.sellAmount,
      'orders': instance.orders,
      'unplaced': instance.unplaced,
      'batchId': instance.batchId,
      'broker': instance.broker,
      'quantity': instance.quantity,
      'status': instance.status,
      'completedDate': instance.completedDate,
      'transactionId': instance.transactionId,
    };

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      orderType: json['orderType'] as String,
      product: json['product'] as String,
      price: (json['price'] as num?)?.toDouble(),
      exchange: json['exchange'] as String,
      averagePrice: (json['averagePrice'] as num?)?.toDouble(),
      status: json['status'] as String,
      filledQuantity: json['filledQuantity'] as int?,
      statusMessage: json['statusMessage'] as String,
      quantity: json['quantity'] as int?,
      orderTimestamp: json['orderTimestamp'] as String,
      transactionType: json['transactionType'] as String,
      triggerPrice: (json['triggerPrice'] as num?)?.toDouble(),
      tradingsymbol: json['tradingsymbol'] as String,
      exchangeOrderId: json['exchangeOrderId'] as String,
      errorCode: json['errorCode'] as String,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'orderType': instance.orderType,
      'product': instance.product,
      'price': instance.price,
      'exchange': instance.exchange,
      'averagePrice': instance.averagePrice,
      'status': instance.status,
      'filledQuantity': instance.filledQuantity,
      'statusMessage': instance.statusMessage,
      'quantity': instance.quantity,
      'orderTimestamp': instance.orderTimestamp,
      'transactionType': instance.transactionType,
      'triggerPrice': instance.triggerPrice,
      'tradingsymbol': instance.tradingsymbol,
      'exchangeOrderId': instance.exchangeOrderId,
      'errorCode': instance.errorCode,
    };
