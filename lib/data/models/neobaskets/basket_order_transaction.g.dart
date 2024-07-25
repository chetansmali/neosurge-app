// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_order_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasketOrderTransactionDetail _$BasketOrderTransactionDetailFromJson(
        Map<String, dynamic> json) =>
    BasketOrderTransactionDetail(
      basketName: json['basketName'] as String?,
      transactionType: json['transactionType'] as String?,
      date: json['date'] as String?,
      type: json['type'] as String?,
      amount: (json['amount'] as num).toDouble(),
      fundsCount: json['fundsCount'] as int,
      orderRef: json['orderRef'] as String?,
      funds: (json['funds'] as List<dynamic>)
          .map((e) => Fund.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BasketOrderTransactionDetailToJson(
        BasketOrderTransactionDetail instance) =>
    <String, dynamic>{
      'basketName': instance.basketName,
      'transactionType': instance.transactionType,
      'date': instance.date,
      'type': instance.type,
      'amount': instance.amount,
      'fundsCount': instance.fundsCount,
      'orderRef': instance.orderRef,
      'funds': instance.funds,
    };

Fund _$FundFromJson(Map<String, dynamic> json) => Fund(
      name: json['name'] as String,
      transactionID: json['transactionID'] as String,
      amount: (json['amount'] as num).toDouble(),
      status: json['status'] as String,
      units: (json['units'] as num?)?.toDouble(),
      nav: (json['nav'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$FundToJson(Fund instance) => <String, dynamic>{
      'name': instance.name,
      'transactionID': instance.transactionID,
      'amount': instance.amount,
      'status': instance.status,
      'units': instance.units,
      'nav': instance.nav,
    };
