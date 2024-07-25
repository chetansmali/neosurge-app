// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mutual_fund.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MutualFund _$MutualFundFromJson(Map<String, dynamic> json) => MutualFund(
      schemeCode: json['schemeCode'] as String,
      schemeName: json['schemeName'] as String,
      fundSize: (json['fundSize'] as num).toDouble(),
      expenseRatio: (json['expenseRatio'] as num).toDouble(),
      assetCategory: json['assetCategory'] as String,
      assetSubCategory: json['assetSubCategory'] as String,
      primarySector: json['primarySector'] as String?,
      imgUrl: json['imgUrl'] as String?,
      oneM: (json['_1M'] as num?)?.toDouble(),
      threeM: (json['_3M'] as num?)?.toDouble(),
      sixM: (json['_6M'] as num?)?.toDouble(),
      nineM: (json['_9M'] as num?)?.toDouble(),
      oneY: (json['_1Y'] as num?)?.toDouble(),
      twoY: (json['_2Y'] as num?)?.toDouble(),
      threeY: (json['_3Y'] as num?)?.toDouble(),
      fiveY: (json['_5Y'] as num?)?.toDouble(),
      savenY: (json['_7Y'] as num?)?.toDouble(),
      tenY: (json['_10Y'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$MutualFundToJson(MutualFund instance) =>
    <String, dynamic>{
      'schemeCode': instance.schemeCode,
      'schemeName': instance.schemeName,
      'fundSize': instance.fundSize,
      'expenseRatio': instance.expenseRatio,
      'assetCategory': instance.assetCategory,
      'assetSubCategory': instance.assetSubCategory,
      'primarySector': instance.primarySector,
      'imgUrl': instance.imgUrl,
      '_1M': instance.oneM,
      '_3M': instance.threeM,
      '_6M': instance.sixM,
      '_9M': instance.nineM,
      '_1Y': instance.oneY,
      '_2Y': instance.twoY,
      '_3Y': instance.threeY,
      '_5Y': instance.fiveY,
      '_7Y': instance.savenY,
      '_10Y': instance.tenY,
    };
