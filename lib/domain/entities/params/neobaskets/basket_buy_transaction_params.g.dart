// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_buy_transaction_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasketBuyTransactionParams _$BasketBuyTransactionParamsFromJson(
        Map<String, dynamic> json) =>
    BasketBuyTransactionParams(
      basketId: json['basketID'] as String,
      sortBy: json['sortBy'] as String?,
    );

Map<String, dynamic> _$BasketBuyTransactionParamsToJson(
        BasketBuyTransactionParams instance) =>
    <String, dynamic>{
      'basketID': instance.basketId,
      'sortBy': instance.sortBy,
    };
