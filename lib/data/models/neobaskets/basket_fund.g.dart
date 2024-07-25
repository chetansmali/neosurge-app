// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_fund.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasketFund _$BasketFundFromJson(Map<String, dynamic> json) => BasketFund(
      id: json['id'] as int,
      basketId: json['basketID'] as String?,
      fundName: json['fundName'] as String?,
      schemeCode: json['schemeCode'] as String?,
      aum: (json['aum'] as num?)?.toDouble(),
      cagr: (json['cagr'] as num?)?.toDouble(),
      amc: json['amc'] as String?,
      exitLoad: (json['exitLoad'] as num?)?.toDouble(),
      allocationPercentage: (json['allocationPercentage'] as num?)?.toDouble(),
      fundCategory: json['fundCategory'] as String?,
      returns: (json['returns'] as num?)?.toDouble(),
      logoUrl: json['logoURL'] as String?,
      minSip: (json['minSip'] as num?)?.toDouble(),
      minLumpsum: (json['minLumpsum'] as num?)?.toDouble(),
      amcCode: json['amcCode'] as String?,
      isin: json['isin'] as String?,
    );

Map<String, dynamic> _$BasketFundToJson(BasketFund instance) =>
    <String, dynamic>{
      'id': instance.id,
      'basketID': instance.basketId,
      'fundName': instance.fundName,
      'schemeCode': instance.schemeCode,
      'aum': instance.aum,
      'cagr': instance.cagr,
      'amc': instance.amc,
      'exitLoad': instance.exitLoad,
      'allocationPercentage': instance.allocationPercentage,
      'fundCategory': instance.fundCategory,
      'returns': instance.returns,
      'logoURL': instance.logoUrl,
      'minSip': instance.minSip,
      'minLumpsum': instance.minLumpsum,
      'amcCode': instance.amcCode,
      'isin': instance.isin,
    };
