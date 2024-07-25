// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smart_watchlist_search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SmartWatchlistSearchModel _$SmartWatchlistSearchModelFromJson(
        Map<String, dynamic> json) =>
    SmartWatchlistSearchModel(
      id: json['id'] as String?,
      symbol: json['symbol'] as String?,
      companyName: json['companyName'] as String?,
      industry: json['industry'] as String?,
      close: (json['close'] as num?)?.toDouble(),
      change: (json['change'] as num?)?.toDouble(),
      percentChange: (json['percentChange'] as num?)?.toDouble(),
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$SmartWatchlistSearchModelToJson(
        SmartWatchlistSearchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'companyName': instance.companyName,
      'industry': instance.industry,
      'close': instance.close,
      'change': instance.change,
      'percentChange': instance.percentChange,
      'icon': instance.icon,
    };
