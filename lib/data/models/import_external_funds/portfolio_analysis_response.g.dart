// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_analysis_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PortfolioAnalysisResponse _$PortfolioAnalysisResponseFromJson(
        Map<String, dynamic> json) =>
    PortfolioAnalysisResponse(
      amcBasedHoldings: (json['amcBasedHoldings'] as List<dynamic>?)
          ?.map((e) => AmcBasedHoldings.fromJson(e as Map<String, dynamic>))
          .toList(),
      topHoldings: (json['topHoldings'] as List<dynamic>?)
          ?.map((e) => TopHoldings.fromJson(e as Map<String, dynamic>))
          .toList(),
      subcategoriesPercentage:
          (json['subcategoriesPercentage'] as List<dynamic>?)
              ?.map((e) =>
                  SubcategoriesPercentage.fromJson(e as Map<String, dynamic>))
              .toList(),
      sectorsPercentage: (json['sectorsPercentage'] as List<dynamic>?)
          ?.map((e) => SectorsPercentage.fromJson(e as Map<String, dynamic>))
          .toList(),
      benchmarkValue: (json['benchmarkValue'] as num?)?.toDouble(),
      error: json['error'] as bool?,
      errorMessage: json['errorMessage'] as String?,
    );

Map<String, dynamic> _$PortfolioAnalysisResponseToJson(
        PortfolioAnalysisResponse instance) =>
    <String, dynamic>{
      'amcBasedHoldings': instance.amcBasedHoldings,
      'topHoldings': instance.topHoldings,
      'subcategoriesPercentage': instance.subcategoriesPercentage,
      'sectorsPercentage': instance.sectorsPercentage,
      'benchmarkValue': instance.benchmarkValue,
      'error': instance.error,
      'errorMessage': instance.errorMessage,
    };

AmcBasedHoldings _$AmcBasedHoldingsFromJson(Map<String, dynamic> json) =>
    AmcBasedHoldings(
      id: json['id'] as int?,
      userID: json['userID'] as int?,
      amcName: json['amcName'] as String?,
      currentValue: (json['currentValue'] as num?)?.toDouble(),
      investedValue: (json['investedValue'] as num?)?.toDouble(),
      returnsValue: (json['returnsValue'] as num?)?.toDouble(),
      holdingsPercentage: (json['holdingsPercentage'] as num?)?.toDouble(),
      amcURL: json['amcURL'] as String?,
    );

Map<String, dynamic> _$AmcBasedHoldingsToJson(AmcBasedHoldings instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userID': instance.userID,
      'amcName': instance.amcName,
      'currentValue': instance.currentValue,
      'investedValue': instance.investedValue,
      'returnsValue': instance.returnsValue,
      'holdingsPercentage': instance.holdingsPercentage,
      'amcURL': instance.amcURL,
    };

TopHoldings _$TopHoldingsFromJson(Map<String, dynamic> json) => TopHoldings(
      id: json['id'] as int?,
      userID: json['userID'] as int?,
      holdingName: json['holdingName'] as String?,
      holdingsPercentage: (json['holdingsPercentage'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$TopHoldingsToJson(TopHoldings instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userID': instance.userID,
      'holdingName': instance.holdingName,
      'holdingsPercentage': instance.holdingsPercentage,
    };

SubcategoriesPercentage _$SubcategoriesPercentageFromJson(
        Map<String, dynamic> json) =>
    SubcategoriesPercentage(
      id: json['id'] as int?,
      userID: json['userID'] as int?,
      subcatgeory: json['subcatgeory'] as String?,
      percentage: (json['percentage'] as num?)?.toDouble(),
      color: json['color'] as int?,
    );

Map<String, dynamic> _$SubcategoriesPercentageToJson(
        SubcategoriesPercentage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userID': instance.userID,
      'subcatgeory': instance.subcatgeory,
      'percentage': instance.percentage,
      'color': instance.color,
    };

SectorsPercentage _$SectorsPercentageFromJson(Map<String, dynamic> json) =>
    SectorsPercentage(
      id: json['id'] as int?,
      userID: json['userID'] as int?,
      sector: json['sector'] as String?,
      percentage: (json['percentage'] as num?)?.toDouble(),
      color: json['color'] as int?,
    );

Map<String, dynamic> _$SectorsPercentageToJson(SectorsPercentage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userID': instance.userID,
      'sector': instance.sector,
      'percentage': instance.percentage,
      'color': instance.color,
    };
