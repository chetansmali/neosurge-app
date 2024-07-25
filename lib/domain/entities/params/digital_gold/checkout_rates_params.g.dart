// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_rates_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckoutRatesParams _$CheckoutRatesParamsFromJson(Map<String, dynamic> json) =>
    CheckoutRatesParams(
      weight: (json['weight'] as num).toDouble(),
      transactionType: $enumDecode(_$DGTransactionTypeEnumMap, json['type']),
      metalType: $enumDecode(_$MetalTypeEnumMap, json['metalType']),
      unit: $enumDecode(_$GoldSilverUnitTypeEnumMap, json['unit']),
    );

Map<String, dynamic> _$CheckoutRatesParamsToJson(
        CheckoutRatesParams instance) =>
    <String, dynamic>{
      'weight': instance.weight,
      'type': _$DGTransactionTypeEnumMap[instance.transactionType]!,
      'metalType': _$MetalTypeEnumMap[instance.metalType]!,
      'unit': _$GoldSilverUnitTypeEnumMap[instance.unit]!,
    };

const _$DGTransactionTypeEnumMap = {
  DGTransactionType.buy: 'buy',
  DGTransactionType.sell: 'sell',
  DGTransactionType.delivery: 'delivery',
  DGTransactionType.buySell: 'buy/sell',
};

const _$MetalTypeEnumMap = {
  MetalType.gold: 'gold',
  MetalType.silver: 'silver',
};

const _$GoldSilverUnitTypeEnumMap = {
  GoldSilverUnitType.gram: 'gms',
  GoldSilverUnitType.rupee: 'inr',
};
