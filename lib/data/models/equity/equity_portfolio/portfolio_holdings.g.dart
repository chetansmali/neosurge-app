// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_holdings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PortfolioHoldingsModel _$PortfolioHoldingsModelFromJson(
        Map<String, dynamic> json) =>
    PortfolioHoldingsModel(
      holdings: (json['holdings'] as List<dynamic>?)
          ?.map((e) => Holding.fromJson(e as Map<String, dynamic>))
          .toList(),
      investedValue: (json['investedValue'] as num?)?.toDouble(),
      currentValue: (json['currentValue'] as num?)?.toDouble(),
      returns: (json['returns'] as num?)?.toDouble(),
      percentageReturns: (json['percentageReturns'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PortfolioHoldingsModelToJson(
        PortfolioHoldingsModel instance) =>
    <String, dynamic>{
      'holdings': instance.holdings,
      'investedValue': instance.investedValue,
      'currentValue': instance.currentValue,
      'returns': instance.returns,
      'percentageReturns': instance.percentageReturns,
    };

Holding _$HoldingFromJson(Map<String, dynamic> json) => Holding(
      holdingKey: json['holdingKey'] as String?,
      companyName: json['companyName'] as String?,
      icon: json['icon'] as String?,
      investedValue: (json['investedValue'] as num?)?.toDouble(),
      avgPrice: (json['avgPrice'] as num?)?.toDouble(),
      quantity: json['quantity'] as int?,
      lastTradedPrice: (json['lastTradedPrice'] as num?)?.toDouble(),
      lastTradedPricePercentageChange:
          (json['lastTradedPricePercentageChange'] as num?)?.toDouble(),
      returns: (json['returns'] as num?)?.toDouble(),
      percentageReturns: (json['percentageReturns'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$HoldingToJson(Holding instance) => <String, dynamic>{
      'holdingKey': instance.holdingKey,
      'companyName': instance.companyName,
      'icon': instance.icon,
      'investedValue': instance.investedValue,
      'avgPrice': instance.avgPrice,
      'quantity': instance.quantity,
      'lastTradedPrice': instance.lastTradedPrice,
      'lastTradedPricePercentageChange':
          instance.lastTradedPricePercentageChange,
      'returns': instance.returns,
      'percentageReturns': instance.percentageReturns,
    };
