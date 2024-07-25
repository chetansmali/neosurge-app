// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gold_silver_rates_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoldSilverRatesModel _$GoldSilverRatesModelFromJson(
        Map<String, dynamic> json) =>
    GoldSilverRatesModel(
      id: json['id'] as int,
      blockId: json['blockId'] as String,
      goldBuyRate: (json['goldBuyRate'] as num).toDouble(),
      goldSellRate: (json['goldSellRate'] as num).toDouble(),
      silverBuyRate: (json['silverBuyRate'] as num).toDouble(),
      silverSellRate: (json['silverSellRate'] as num).toDouble(),
      cgstPercentage: (json['cgstPercentage'] as num).toDouble(),
      sgstPercentage: (json['sgstPercentage'] as num).toDouble(),
      igstPercentage: (json['igstPercentage'] as num).toDouble(),
    );

Map<String, dynamic> _$GoldSilverRatesModelToJson(
        GoldSilverRatesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'blockId': instance.blockId,
      'goldBuyRate': instance.goldBuyRate,
      'goldSellRate': instance.goldSellRate,
      'silverBuyRate': instance.silverBuyRate,
      'silverSellRate': instance.silverSellRate,
      'cgstPercentage': instance.cgstPercentage,
      'sgstPercentage': instance.sgstPercentage,
      'igstPercentage': instance.igstPercentage,
    };
