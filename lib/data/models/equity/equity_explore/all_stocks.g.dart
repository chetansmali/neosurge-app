// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_stocks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllStocksModel _$AllStocksModelFromJson(Map<String, dynamic> json) =>
    AllStocksModel(
      id: json['id'] as String?,
      symbol: json['symbol'] as String?,
      companyName: json['companyName'] as String?,
      industry: json['industry'] as String?,
      close: (json['close'] as num?)?.toDouble(),
      change: (json['change'] as num?)?.toDouble(),
      percentChange: (json['percentChange'] as num?)?.toDouble(),
      icon: json['icon'] as String?,
      isinCode: json['isinCode'] as String?,
    );

Map<String, dynamic> _$AllStocksModelToJson(AllStocksModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'companyName': instance.companyName,
      'industry': instance.industry,
      'close': instance.close,
      'change': instance.change,
      'percentChange': instance.percentChange,
      'isinCode': instance.isinCode,
      'icon': instance.icon,
    };
