// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_buy_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasketBuyTransaction _$BasketBuyTransactionFromJson(
        Map<String, dynamic> json) =>
    BasketBuyTransaction(
      orderRef: json['orderRef'] as String?,
      date: json['date'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      type: json['type'] as String?,
    );

Map<String, dynamic> _$BasketBuyTransactionToJson(
        BasketBuyTransaction instance) =>
    <String, dynamic>{
      'orderRef': instance.orderRef,
      'date': instance.date,
      'amount': instance.amount,
      'type': instance.type,
    };
