// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fund_holding.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FundHolding _$FundHoldingFromJson(Map<String, dynamic> json) => FundHolding(
      marketValue: (json['market_value'] as num).toDouble(),
      asOnDate: json['as_on_date'] as String,
      security: json['security'] as String,
      quantity: json['quantity'] as int,
      coupon: (json['coupon'] as num).toDouble(),
      agency: json['agency'] as String,
      holdingPerc: (json['holding_perc'] as num).toDouble(),
      mktCapCategory: json['mkt_cap_category'] as String,
      rating: json['rating'] as String,
      sector: json['sector'] as String,
      equivRating: json['equiv_rating'] as String,
      isinSecurity: json['isin_security'] as String,
    );

Map<String, dynamic> _$FundHoldingToJson(FundHolding instance) =>
    <String, dynamic>{
      'market_value': instance.marketValue,
      'as_on_date': instance.asOnDate,
      'security': instance.security,
      'quantity': instance.quantity,
      'coupon': instance.coupon,
      'agency': instance.agency,
      'holding_perc': instance.holdingPerc,
      'mkt_cap_category': instance.mktCapCategory,
      'rating': instance.rating,
      'sector': instance.sector,
      'equiv_rating': instance.equivRating,
      'isin_security': instance.isinSecurity,
    };
