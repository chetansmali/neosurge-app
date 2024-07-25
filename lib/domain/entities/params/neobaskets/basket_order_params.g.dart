// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_order_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasketOrderParams _$BasketOrderParamsFromJson(Map<String, dynamic> json) =>
    BasketOrderParams(
      basketId: json['basketID'] as String,
      amount: json['amount'] as int,
      monthlyInvDate: json['invDate'] as String?,
      installments: json['installments'] as int?,
    );

Map<String, dynamic> _$BasketOrderParamsToJson(BasketOrderParams instance) {
  final val = <String, dynamic>{
    'basketID': instance.basketId,
    'amount': instance.amount,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('invDate', instance.monthlyInvDate);
  writeNotNull('installments', instance.installments);
  return val;
}
