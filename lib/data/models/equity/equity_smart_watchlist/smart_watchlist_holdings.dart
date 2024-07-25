import 'package:json_annotation/json_annotation.dart';
part 'smart_watchlist_holdings.g.dart';

@JsonSerializable()
class SmartWatchlistHoldingsModel {
  final String? holdingKey;
  final String? companyName;
  final String? icon;
  final double? investedValue;
  final double? avgPrice;
  final int? quantity;
  final double? lastTradedPrice;
  final double? lastTradedPriceChange;
  final double? lastTradedPricePercentageChange;
  final double? returns;
  final double? percentageReturns;

  SmartWatchlistHoldingsModel({
    required this.holdingKey,
    required this.companyName,
    required this.icon,
    required this.investedValue,
    required this.avgPrice,
    required this.quantity,
    required this.lastTradedPrice,
    required this.lastTradedPriceChange,
    required this.lastTradedPricePercentageChange,
    required this.returns,
    required this.percentageReturns,
  });

  factory SmartWatchlistHoldingsModel.fromJson(Map<String, dynamic> json) =>
      _$SmartWatchlistHoldingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SmartWatchlistHoldingsModelToJson(this);

  static List<SmartWatchlistHoldingsModel> listFromJson(List<dynamic> json) =>
      json.map((e) => SmartWatchlistHoldingsModel.fromJson(e)).toList();
}
