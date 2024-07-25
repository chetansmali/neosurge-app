// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_stock_watchlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddStockWatchlistParams _$AddStockWatchlistParamsFromJson(
        Map<String, dynamic> json) =>
    AddStockWatchlistParams(
      watchlistId: json['watchlistId'] as int,
      symbol: json['symbol'] as String,
    );

Map<String, dynamic> _$AddStockWatchlistParamsToJson(
        AddStockWatchlistParams instance) =>
    <String, dynamic>{
      'watchlistId': instance.watchlistId,
      'symbol': instance.symbol,
    };
