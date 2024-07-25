// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GlobalSearchModel _$GlobalSearchModelFromJson(Map<String, dynamic> json) =>
    GlobalSearchModel(
      symbol: json['symbol'] as String,
      exchange: json['exchange'] as String,
      country: json['country'] as String,
      currency: json['currency'] as String,
      instrumentName: json['instrumentName'] as String?,
      micCode: json['micCode'] as String?,
      exchangeTimezone: json['exchangeTimezone'] as String?,
      instrumentType: json['instrumentType'] as String?,
    );

Map<String, dynamic> _$GlobalSearchModelToJson(GlobalSearchModel instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'exchange': instance.exchange,
      'country': instance.country,
      'currency': instance.currency,
      'instrumentName': instance.instrumentName,
      'micCode': instance.micCode,
      'exchangeTimezone': instance.exchangeTimezone,
      'instrumentType': instance.instrumentType,
    };
