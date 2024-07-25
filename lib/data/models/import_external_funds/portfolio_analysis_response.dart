import 'dart:math';

import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';

part 'portfolio_analysis_response.g.dart';

@JsonSerializable()
class PortfolioAnalysisResponse {
  List<AmcBasedHoldings>? amcBasedHoldings;
  List<TopHoldings>? topHoldings;
  List<SubcategoriesPercentage>? subcategoriesPercentage;
  List<SectorsPercentage>? sectorsPercentage;
  double? benchmarkValue;
  bool? error;
  String? errorMessage;

  PortfolioAnalysisResponse({
    this.amcBasedHoldings,
    this.topHoldings,
    this.subcategoriesPercentage,
    this.sectorsPercentage,
    this.benchmarkValue,
    this.error,
    this.errorMessage,
  });

  factory PortfolioAnalysisResponse.fromJson(Map<String, dynamic> json) =>
      _$PortfolioAnalysisResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PortfolioAnalysisResponseToJson(this);
}

@JsonSerializable()
class AmcBasedHoldings {
  int? id;
  int? userID;
  String? amcName;
  double? currentValue;
  double? investedValue;
  double? returnsValue;
  double? holdingsPercentage;
  String? amcURL;

  AmcBasedHoldings({
    this.id,
    this.userID,
    this.amcName,
    this.currentValue,
    this.investedValue,
    this.returnsValue,
    this.holdingsPercentage,
    this.amcURL,
  });

  factory AmcBasedHoldings.fromJson(Map<String, dynamic> json) =>
      _$AmcBasedHoldingsFromJson(json);

  Map<String, dynamic> toJson() => _$AmcBasedHoldingsToJson(this);
}

@JsonSerializable()
class TopHoldings {
  int? id;
  int? userID;
  String? holdingName;
  double? holdingsPercentage;

  TopHoldings({
    this.id,
    this.userID,
    this.holdingName,
    this.holdingsPercentage,
  });

  factory TopHoldings.fromJson(Map<String, dynamic> json) =>
      _$TopHoldingsFromJson(json);

  Map<String, dynamic> toJson() => _$TopHoldingsToJson(this);
}

@JsonSerializable()
class SubcategoriesPercentage {
  int? id;
  int? userID;
  String? subcatgeory;
  double? percentage;
  int? color;

  SubcategoriesPercentage({
    this.id,
    this.userID,
    this.subcatgeory,
    this.percentage,
    this.color,
  });

  factory SubcategoriesPercentage.fromJson(Map<String, dynamic> json) {
    json['color'] = Color((Random().nextDouble() * 0xFFFFFF).toInt())
        .withOpacity(1.0)
        .value;

    return _$SubcategoriesPercentageFromJson(
      json,
    );
  }

  Map<String, dynamic> toJson() => _$SubcategoriesPercentageToJson(this);
}

@JsonSerializable()
class SectorsPercentage {
  int? id;
  int? userID;
  String? sector;
  double? percentage;
  int? color;

  SectorsPercentage({
    this.id,
    this.userID,
    this.sector,
    this.percentage,
    this.color,
  });

  factory SectorsPercentage.fromJson(Map<String, dynamic> json) {
    json['color'] = Color((Random().nextDouble() * 0xFFFFFF).toInt())
        .withOpacity(1.0)
        .value;

    return _$SectorsPercentageFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SectorsPercentageToJson(this);
}
