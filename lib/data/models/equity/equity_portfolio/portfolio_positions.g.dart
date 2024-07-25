// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_positions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PortfolioPositionModel _$PortfolioPositionModelFromJson(
        Map<String, dynamic> json) =>
    PortfolioPositionModel(
      smallcaseAuthId: json['smallcaseAuthId'] as String,
      positions: (json['positions'] as List<dynamic>)
          .map((e) => Position.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PortfolioPositionModelToJson(
        PortfolioPositionModel instance) =>
    <String, dynamic>{
      'smallcaseAuthId': instance.smallcaseAuthId,
      'positions': instance.positions,
    };

Position _$PositionFromJson(Map<String, dynamic> json) => Position(
      positionKeyObject: PositionKeyObject.fromJson(
          json['positionKeyObject'] as Map<String, dynamic>),
      transactionId: json['transactionId'] as String,
      smallcaseAuthId: json['smallcaseAuthId'] as String,
      creationMonthYear: json['creationMonthYear'] as String,
      creationDay: json['creationDay'] as int,
      exchangeOrderId: json['exchangeOrderId'],
      status: json['status'] as String,
      orderType: json['orderType'] as String,
      product: json['product'] as String,
      exchange: json['exchange'] as String,
      broker: json['broker'] as String,
      quantity: json['quantity'] as int,
      tradingSymbol: json['tradingSymbol'] as String,
      companyName: json['companyName'] as String?,
      icon: json['icon'] as String?,
      transactionType: json['transactionType'] as String?,
      filledQuantity: json['filledQuantity'] as int?,
      averagePrice: (json['averagePrice'] as num).toDouble(),
      txnCompletedDateTime:
          DateTime.parse(json['txnCompletedDateTime'] as String),
      batchId: json['batchId'] as String?,
      type: json['type'] as String?,
      errorCode: json['errorCode'],
      statusMessage: json['statusMessage'] as String?,
    );

Map<String, dynamic> _$PositionToJson(Position instance) => <String, dynamic>{
      'positionKeyObject': instance.positionKeyObject,
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
      'txnCompletedDateTime': instance.txnCompletedDateTime.toIso8601String(),
      'batchId': instance.batchId,
      'type': instance.type,
      'errorCode': instance.errorCode,
      'statusMessage': instance.statusMessage,
    };

PositionKeyObject _$PositionKeyObjectFromJson(Map<String, dynamic> json) =>
    PositionKeyObject(
      symbol: json['symbol'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$PositionKeyObjectToJson(PositionKeyObject instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'status': instance.status,
    };
