// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smart_watchlist_holdings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SmartWatchlistHoldingsModel _$SmartWatchlistHoldingsModelFromJson(
        Map<String, dynamic> json) =>
    SmartWatchlistHoldingsModel(
      holdingKey: json['holdingKey'] as String?,
      companyName: json['companyName'] as String?,
      icon: json['icon'] as String?,
      investedValue: (json['investedValue'] as num?)?.toDouble(),
      avgPrice: (json['avgPrice'] as num?)?.toDouble(),
      quantity: json['quantity'] as int?,
      lastTradedPrice: (json['lastTradedPrice'] as num?)?.toDouble(),
      lastTradedPriceChange:
          (json['lastTradedPriceChange'] as num?)?.toDouble(),
      lastTradedPricePercentageChange:
          (json['lastTradedPricePercentageChange'] as num?)?.toDouble(),
      returns: (json['returns'] as num?)?.toDouble(),
      percentageReturns: (json['percentageReturns'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SmartWatchlistHoldingsModelToJson(
        SmartWatchlistHoldingsModel instance) =>
    <String, dynamic>{
      'holdingKey': instance.holdingKey,
      'companyName': instance.companyName,
      'icon': instance.icon,
      'investedValue': instance.investedValue,
      'avgPrice': instance.avgPrice,
      'quantity': instance.quantity,
      'lastTradedPrice': instance.lastTradedPrice,
      'lastTradedPriceChange': instance.lastTradedPriceChange,
      'lastTradedPricePercentageChange':
          instance.lastTradedPricePercentageChange,
      'returns': instance.returns,
      'percentageReturns': instance.percentageReturns,
    };
