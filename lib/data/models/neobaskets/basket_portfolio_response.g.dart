// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_portfolio_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasketPortfolioResponse _$BasketPortfolioResponseFromJson(
        Map<String, dynamic> json) =>
    BasketPortfolioResponse(
      portfolioCurrent: (json['portfolioCurrent'] as num?)?.toDouble(),
      portfolioInvested: (json['portfolioInvested'] as num?)?.toDouble(),
      portfolioReturnsPercentage:
          (json['portfolioReturnsPercentage'] as num?)?.toDouble(),
      portfolioReturns: (json['portfolioReturns'] as num?)?.toDouble(),
      baskets: (json['baskets'] as List<dynamic>)
          .map((e) => Basket.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BasketPortfolioResponseToJson(
        BasketPortfolioResponse instance) =>
    <String, dynamic>{
      'portfolioCurrent': instance.portfolioCurrent,
      'portfolioInvested': instance.portfolioInvested,
      'portfolioReturnsPercentage': instance.portfolioReturnsPercentage,
      'portfolioReturns': instance.portfolioReturns,
      'baskets': instance.baskets,
    };

Basket _$BasketFromJson(Map<String, dynamic> json) => Basket(
      basketName: json['basketName'] as String?,
      basketId: json['basketId'] as String?,
      investedValue: (json['investedValue'] as num?)?.toDouble(),
      currentValue: (json['currentValue'] as num?)?.toDouble(),
      returns: (json['returns'] as num?)?.toDouble(),
      returnsPercentage: (json['returnsPercentage'] as num?)?.toDouble(),
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$BasketToJson(Basket instance) => <String, dynamic>{
      'basketName': instance.basketName,
      'basketId': instance.basketId,
      'investedValue': instance.investedValue,
      'currentValue': instance.currentValue,
      'returns': instance.returns,
      'returnsPercentage': instance.returnsPercentage,
      'imageUrl': instance.imageUrl,
    };
