// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_redeem_order_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasketRedeemOrderParams _$BasketRedeemOrderParamsFromJson(
        Map<String, dynamic> json) =>
    BasketRedeemOrderParams(
      basketId: json['basketID'] as String,
      redemptionType: json['redemptionType'] as String,
      isBroken: json['isBroken'] as bool,
      amount: json['amount'] as String?,
      redeemAll: json['redeemAll'] as bool?,
    );

Map<String, dynamic> _$BasketRedeemOrderParamsToJson(
        BasketRedeemOrderParams instance) =>
    <String, dynamic>{
      'basketID': instance.basketId,
      'redemptionType': instance.redemptionType,
      'isBroken': instance.isBroken,
      'amount': instance.amount,
      'redeemAll': instance.redeemAll,
    };
