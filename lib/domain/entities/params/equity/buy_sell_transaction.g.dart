// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buy_sell_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuySellTransactionParams _$BuySellTransactionParamsFromJson(
        Map<String, dynamic> json) =>
    BuySellTransactionParams(
      smallcaseAuthToken: json['smallcaseAuthToken'] as String,
      email: json['email'] as String,
      orderConfig:
          OrderConfig.fromJson(json['orderConfig'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BuySellTransactionParamsToJson(
        BuySellTransactionParams instance) =>
    <String, dynamic>{
      'smallcaseAuthToken': instance.smallcaseAuthToken,
      'email': instance.email,
      'orderConfig': instance.orderConfig,
    };

OrderConfig _$OrderConfigFromJson(Map<String, dynamic> json) => OrderConfig(
      type: json['type'] as String,
      securities: (json['securities'] as List<dynamic>)
          .map((e) => Security.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderConfigToJson(OrderConfig instance) =>
    <String, dynamic>{
      'type': instance.type,
      'securities': instance.securities,
    };

Security _$SecurityFromJson(Map<String, dynamic> json) => Security(
      ticker: json['ticker'] as String,
      type: json['type'] as String,
      quantity: json['quantity'] as int,
    );

Map<String, dynamic> _$SecurityToJson(Security instance) => <String, dynamic>{
      'ticker': instance.ticker,
      'type': instance.type,
      'quantity': instance.quantity,
    };
