import 'package:json_annotation/json_annotation.dart';

part 'basket_portfolio_detail_params.g.dart';

@JsonSerializable()
class BasketPortfolioDetailParams {
  final String basketId;

  BasketPortfolioDetailParams({
    required this.basketId,
  });

  factory BasketPortfolioDetailParams.fromJson(Map<String, dynamic> json) =>
      _$BasketPortfolioDetailParamsFromJson(json);

  Map<String, dynamic> toJson() => _$BasketPortfolioDetailParamsToJson(this);
}
