// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_watchlist_stock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WatchlistStocksModel _$WatchlistStocksModelFromJson(
        Map<String, dynamic> json) =>
    WatchlistStocksModel(
      watchlistId: json['watchlistId'] as int?,
      watchlistContentId: json['watchlistContentId'] as int?,
      symbol: json['symbol'] as String?,
      companyName: json['companyName'] as String?,
      close: (json['close'] as num?)?.toDouble(),
      change: (json['change'] as num?)?.toDouble(),
      percentChange: (json['percentChange'] as num?)?.toDouble(),
      icon: json['icon'] as String?,
      quantity: json['quantity'] as int?,
    );

Map<String, dynamic> _$WatchlistStocksModelToJson(
        WatchlistStocksModel instance) =>
    <String, dynamic>{
      'watchlistId': instance.watchlistId,
      'watchlistContentId': instance.watchlistContentId,
      'symbol': instance.symbol,
      'companyName': instance.companyName,
      'close': instance.close,
      'change': instance.change,
      'percentChange': instance.percentChange,
      'icon': instance.icon,
      'quantity': instance.quantity,
    };
