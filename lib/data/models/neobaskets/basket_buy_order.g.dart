// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_buy_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasketBuyOrder _$BasketBuyOrderFromJson(Map<String, dynamic> json) =>
    BasketBuyOrder(
      basketName: json['basketName'] as String?,
      orderRef: json['orderRef'] as String?,
      date: json['date'] as String?,
      type: json['type'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$BasketBuyOrderToJson(BasketBuyOrder instance) =>
    <String, dynamic>{
      'basketName': instance.basketName,
      'orderRef': instance.orderRef,
      'date': instance.date,
      'type': instance.type,
      'amount': instance.amount,
      'status': instance.status,
    };
