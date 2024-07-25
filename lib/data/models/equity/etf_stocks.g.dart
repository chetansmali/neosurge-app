// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'etf_stocks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ETFStocksModel _$ETFStocksModelFromJson(Map<String, dynamic> json) =>
    ETFStocksModel(
      id: json['id'] as String?,
      symbol: json['symbol'] as String?,
      name: json['name'] as String?,
      icon: json['icon'] as String?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      change: (json['change'] as num?)?.toDouble(),
      close: (json['close'] as num?)?.toDouble(),
      percentChange: (json['percentChange'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ETFStocksModelToJson(ETFStocksModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'name': instance.name,
      'icon': instance.icon,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'change': instance.change,
      'close': instance.close,
      'percentChange': instance.percentChange,
    };
