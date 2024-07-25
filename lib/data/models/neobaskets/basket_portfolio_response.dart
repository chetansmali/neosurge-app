import 'package:json_annotation/json_annotation.dart';

part 'basket_portfolio_response.g.dart';

@JsonSerializable()
class BasketPortfolioResponse {
  final double? portfolioCurrent;
  final double? portfolioInvested;
  final double? portfolioReturnsPercentage;
  final double? portfolioReturns;
  final List<Basket> baskets;

  BasketPortfolioResponse({
    required this.portfolioCurrent,
    required this.portfolioInvested,
    required this.portfolioReturnsPercentage,
    required this.portfolioReturns,
    required this.baskets,
  });

  factory BasketPortfolioResponse.fromJson(Map<String, dynamic> json) =>
      _$BasketPortfolioResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BasketPortfolioResponseToJson(this);
}

@JsonSerializable()
class Basket {
  final String? basketName;
  final String? basketId;
  final double? investedValue;
  final double? currentValue;
  final double? returns;
  final double? returnsPercentage;
  final String? imageUrl;

  Basket({
    required this.basketName,
    required this.basketId,
    required this.investedValue,
    required this.currentValue,
    required this.returns,
    required this.returnsPercentage,
    required this.imageUrl,
  });

  factory Basket.fromJson(Map<String, dynamic> json) => _$BasketFromJson(json);

  Map<String, dynamic> toJson() => _$BasketToJson(this);
}
