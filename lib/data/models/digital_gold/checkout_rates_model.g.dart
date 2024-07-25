// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_rates_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckoutRatesModel _$CheckoutRatesModelFromJson(Map<String, dynamic> json) =>
    CheckoutRatesModel(
      transactionType: $enumDecode(_$DGTransactionTypeEnumMap, json['type']),
      metalType: $enumDecode(_$MetalTypeEnumMap, json['metalType']),
      metalWeight: (json['metalWeight'] as num).toDouble(),
      taxAmount: (json['taxAmount'] as num).toDouble(),
      metalAmount: (json['metalAmount'] as num).toDouble(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      goldSilverRate: GoldSilverRatesModel.fromJson(
          json['goldSilverRate'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CheckoutRatesModelToJson(CheckoutRatesModel instance) =>
    <String, dynamic>{
      'type': _$DGTransactionTypeEnumMap[instance.transactionType]!,
      'metalType': _$MetalTypeEnumMap[instance.metalType]!,
      'metalWeight': instance.metalWeight,
      'taxAmount': instance.taxAmount,
      'metalAmount': instance.metalAmount,
      'totalAmount': instance.totalAmount,
      'goldSilverRate': instance.goldSilverRate,
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
