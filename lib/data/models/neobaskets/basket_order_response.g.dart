// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasketOrderResponse _$BasketOrderResponseFromJson(Map<String, dynamic> json) =>
    BasketOrderResponse(
      status: json['status'] as String?,
      basketName: json['basketName'] as String?,
      orderType: json['orderType'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      message: json['message'] as String?,
      orderRef: json['orderRef'] as String,
      funds: (json['funds'] as List<dynamic>)
          .map((e) => Fund.fromJson(e as Map<String, dynamic>))
          .toList(),
      monthlyInvDate: json['monthlyInvDate'] as int?,
    );

Map<String, dynamic> _$BasketOrderResponseToJson(
        BasketOrderResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'basketName': instance.basketName,
      'orderType': instance.orderType,
      'amount': instance.amount,
      'message': instance.message,
      'orderRef': instance.orderRef,
      'monthlyInvDate': instance.monthlyInvDate,
      'funds': instance.funds,
    };

Fund _$FundFromJson(Map<String, dynamic> json) => Fund(
      fundName: json['fundName'] as String,
      amount: (json['amount'] as num).toDouble(),
    );

Map<String, dynamic> _$FundToJson(Fund instance) => <String, dynamic>{
      'fundName': instance.fundName,
      'amount': instance.amount,
    };
