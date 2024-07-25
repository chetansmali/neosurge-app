// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_sell_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasketSellTransaction _$BasketSellTransactionFromJson(
        Map<String, dynamic> json) =>
    BasketSellTransaction(
      orderRef: json['orderRef'] as String,
      date: json['date'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$BasketSellTransactionToJson(
        BasketSellTransaction instance) =>
    <String, dynamic>{
      'orderRef': instance.orderRef,
      'date': instance.date,
      'amount': instance.amount,
    };
