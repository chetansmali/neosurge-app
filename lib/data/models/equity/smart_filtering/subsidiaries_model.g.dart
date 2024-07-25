// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subsidiaries_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubsidiaryModel _$SubsidiaryModelFromJson(Map<String, dynamic> json) =>
    SubsidiaryModel(
      symbol: json['symbol'] as String?,
      icon: json['icon'] as String?,
      industry: json['industry'] as String?,
      sector: json['sector'] as String?,
      businessHouse: json['businessHouse'] as String?,
      companyName: json['companyName'] as String?,
      marketCapitalization: (json['marketCapitalization'] as num?)?.toDouble(),
      percentChange: (json['percentChange'] as num?)?.toDouble(),
      change: (json['change'] as num?)?.toDouble(),
      close: (json['close'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SubsidiaryModelToJson(SubsidiaryModel instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'icon': instance.icon,
      'industry': instance.industry,
      'sector': instance.sector,
      'businessHouse': instance.businessHouse,
      'companyName': instance.companyName,
      'marketCapitalization': instance.marketCapitalization,
      'percentChange': instance.percentChange,
      'change': instance.change,
      'close': instance.close,
    };
