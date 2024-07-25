// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_portfolio_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasketPortfolioDetailResponse _$BasketPortfolioDetailResponseFromJson(
        Map<String, dynamic> json) =>
    BasketPortfolioDetailResponse(
      basketInvestedValue: (json['basketInvestedValue'] as num?)?.toDouble(),
      basketCurrentValue: (json['basketCurrentValue'] as num?)?.toDouble(),
      basketReturnsValue: (json['basketReturnsValue'] as num?)?.toDouble(),
      basketReturnsPercentage:
          (json['basketReturnsPercentage'] as num?)?.toDouble(),
      basketID: json['basketID'] as String,
      basketState: json['basketState'] as String?,
      basketName: json['basketName'] as String?,
      imageUrl: json['imageUrl'] as String?,
      sip: (json['sip'] as List<dynamic>?)
          ?.map((e) => Sip.fromJson(e as Map<String, dynamic>))
          .toList(),
      funds: (json['funds'] as List<dynamic>)
          .map((e) => Fund.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BasketPortfolioDetailResponseToJson(
        BasketPortfolioDetailResponse instance) =>
    <String, dynamic>{
      'basketInvestedValue': instance.basketInvestedValue,
      'basketCurrentValue': instance.basketCurrentValue,
      'basketReturnsValue': instance.basketReturnsValue,
      'basketReturnsPercentage': instance.basketReturnsPercentage,
      'basketID': instance.basketID,
      'basketState': instance.basketState,
      'basketName': instance.basketName,
      'imageUrl': instance.imageUrl,
      'sip': instance.sip,
      'funds': instance.funds,
    };

Sip _$SipFromJson(Map<String, dynamic> json) => Sip(
      amount: (json['amount'] as num).toDouble(),
      investmentDate: json['investmentDate'] as String,
      sipEnd: json['sipEnd'] as String,
      orderRef: json['orderRef'] as String,
    );

Map<String, dynamic> _$SipToJson(Sip instance) => <String, dynamic>{
      'amount': instance.amount,
      'investmentDate': instance.investmentDate,
      'sipEnd': instance.sipEnd,
      'orderRef': instance.orderRef,
    };

Fund _$FundFromJson(Map<String, dynamic> json) => Fund(
      fundIsin: json['fundIsin'] as String,
      fundName: json['fundName'] as String,
      logoUrl: json['logoUrl'] as String,
      current: (json['current'] as num).toDouble(),
      invested: (json['invested'] as num).toDouble(),
      returns: (json['returns'] as num).toDouble(),
      returnsPercentage: (json['returnsPercentage'] as num?)?.toDouble(),
      folioNumber: json['folioNumber'] as String,
      units: (json['units'] as num).toDouble(),
      avgNav: (json['avgNav'] as num).toDouble(),
      allocationPercentage: (json['allocationPercentage'] as num).toDouble(),
      maxRedeemAmount: (json['maxRedeemAmount'] as num).toDouble(),
      maxRedeemUnit: (json['maxRedeemUnit'] as num).toDouble(),
    );

Map<String, dynamic> _$FundToJson(Fund instance) => <String, dynamic>{
      'fundIsin': instance.fundIsin,
      'fundName': instance.fundName,
      'logoUrl': instance.logoUrl,
      'current': instance.current,
      'invested': instance.invested,
      'returns': instance.returns,
      'returnsPercentage': instance.returnsPercentage,
      'folioNumber': instance.folioNumber,
      'units': instance.units,
      'avgNav': instance.avgNav,
      'allocationPercentage': instance.allocationPercentage,
      'maxRedeemAmount': instance.maxRedeemAmount,
      'maxRedeemUnit': instance.maxRedeemUnit,
    };
