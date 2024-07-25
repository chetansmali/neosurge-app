import 'package:json_annotation/json_annotation.dart';
part 'portfolio_holdings.g.dart';

@JsonSerializable()
class PortfolioHoldingsModel {
  final List<Holding>? holdings;
  final double? investedValue;
  final double? currentValue;
  final double? returns;
  final double? percentageReturns;

  PortfolioHoldingsModel({
    required this.holdings,
    required this.investedValue,
    required this.currentValue,
    required this.returns,
    required this.percentageReturns,
  });

  factory PortfolioHoldingsModel.fromJson(Map<String, dynamic> json) =>
      _$PortfolioHoldingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PortfolioHoldingsModelToJson(this);
}

@JsonSerializable()
class Holding {
  final String? holdingKey;
  final String? companyName;
  final String? icon;
  final double? investedValue;
  final double? avgPrice;
  final int? quantity;
  final double? lastTradedPrice;
  final double? lastTradedPricePercentageChange;
  final double? returns;
  final double? percentageReturns;

  Holding({
    required this.holdingKey,
    required this.companyName,
    required this.icon,
    required this.investedValue,
    required this.avgPrice,
    required this.quantity,
    required this.lastTradedPrice,
    required this.lastTradedPricePercentageChange,
    required this.returns,
    required this.percentageReturns,
  });

  factory Holding.fromJson(Map<String, dynamic> json) =>
      _$HoldingFromJson(json);

  Map<String, dynamic> toJson() => _$HoldingToJson(this);
}
