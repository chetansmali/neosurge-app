// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equity_orders_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EquityOrderModel _$EquityOrderModelFromJson(Map<String, dynamic> json) =>
    EquityOrderModel(
      transactionId: json['transactionId'] as String?,
      smallcaseAuthId: json['smallcaseAuthId'] as String?,
      creationMonthYear: json['creationMonthYear'] as String?,
      creationDay: json['creationDay'] as int?,
      exchangeOrderId: json['exchangeOrderId'] as String?,
      status: json['status'] as String?,
      orderType: json['orderType'] as String?,
      product: json['product'] as String?,
      exchange: json['exchange'] as String?,
      broker: json['broker'] as String?,
      quantity: json['quantity'] as int?,
      tradingSymbol: json['tradingSymbol'] as String?,
      companyName: json['companyName'] as String?,
      icon: json['icon'] as String?,
      transactionType: json['transactionType'] as String?,
      filledQuantity: json['filledQuantity'] as int?,
      averagePrice: (json['averagePrice'] as num?)?.toDouble(),
      txnCompletedDateTime: json['txnCompletedDateTime'] == null
          ? null
          : DateTime.parse(json['txnCompletedDateTime'] as String),
      batchId: json['batchId'] as String?,
      type: json['type'] as String?,
      errorCode: json['errorCode'] as String?,
      statusMessage: json['statusMessage'] as String?,
    );

Map<String, dynamic> _$EquityOrderModelToJson(EquityOrderModel instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'smallcaseAuthId': instance.smallcaseAuthId,
      'creationMonthYear': instance.creationMonthYear,
      'creationDay': instance.creationDay,
      'exchangeOrderId': instance.exchangeOrderId,
      'status': instance.status,
      'orderType': instance.orderType,
      'product': instance.product,
      'exchange': instance.exchange,
      'broker': instance.broker,
      'quantity': instance.quantity,
      'tradingSymbol': instance.tradingSymbol,
      'companyName': instance.companyName,
      'icon': instance.icon,
      'transactionType': instance.transactionType,
      'filledQuantity': instance.filledQuantity,
      'averagePrice': instance.averagePrice,
      'txnCompletedDateTime': instance.txnCompletedDateTime?.toIso8601String(),
      'batchId': instance.batchId,
      'type': instance.type,
      'errorCode': instance.errorCode,
      'statusMessage': instance.statusMessage,
    };
