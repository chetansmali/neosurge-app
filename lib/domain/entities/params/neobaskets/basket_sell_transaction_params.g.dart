// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_sell_transaction_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasketSellTransactionParams _$BasketSellTransactionParamsFromJson(
        Map<String, dynamic> json) =>
    BasketSellTransactionParams(
      basketId: json['basketID'] as String,
      sortBy: json['sortBy'] as String?,
    );

Map<String, dynamic> _$BasketSellTransactionParamsToJson(
        BasketSellTransactionParams instance) =>
    <String, dynamic>{
      'basketID': instance.basketId,
      'sortBy': instance.sortBy,
    };
