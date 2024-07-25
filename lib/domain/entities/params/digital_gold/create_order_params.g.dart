// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOrderParams _$CreateOrderParamsFromJson(Map<String, dynamic> json) =>
    CreateOrderParams(
      metalType: $enumDecode(_$MetalTypeEnumMap, json['metalType']),
      amount: (json['amount'] as num).toDouble(),
      blockId: json['blockId'] as String,
      lockPrice: (json['lockPrice'] as num).toDouble(),
      transactionType: $enumDecode(_$DGTransactionTypeEnumMap, json['type']),
      metalWeight: (json['metalWeight'] as num).toDouble(),
    );

Map<String, dynamic> _$CreateOrderParamsToJson(CreateOrderParams instance) =>
    <String, dynamic>{
      'metalType': _$MetalTypeEnumMap[instance.metalType]!,
      'amount': instance.amount,
      'blockId': instance.blockId,
      'lockPrice': instance.lockPrice,
      'type': _$DGTransactionTypeEnumMap[instance.transactionType]!,
      'metalWeight': instance.metalWeight,
    };

const _$MetalTypeEnumMap = {
  MetalType.gold: 'gold',
  MetalType.silver: 'silver',
};

const _$DGTransactionTypeEnumMap = {
  DGTransactionType.buy: 'buy',
  DGTransactionType.sell: 'sell',
  DGTransactionType.delivery: 'delivery',
  DGTransactionType.buySell: 'buy/sell',
};
