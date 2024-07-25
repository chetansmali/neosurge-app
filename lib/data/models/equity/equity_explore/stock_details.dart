import 'package:json_annotation/json_annotation.dart';

part 'stock_details.g.dart';

@JsonSerializable()
class StockDetailsModel {
  final Quote? quote;
  final Profile? profile;
  final Fundamentals? fundamentals;

  StockDetailsModel({
    required this.quote,
    required this.profile,
    required this.fundamentals,
  });

  factory StockDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$StockDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$StockDetailsModelToJson(this);
}

@JsonSerializable()
class Fundamentals {
  final Id? id;
  final ValuationsMetrics? valuationsMetrics;
  final Financials? financials;
  final DividendsAndSplits? dividendsAndSplits;
  final double? oneMonthReturn;
  final double? oneYearReturn;
  final double? fiveYearReturn;

  Fundamentals({
    required this.id,
    required this.valuationsMetrics,
    required this.financials,
    required this.dividendsAndSplits,
    required this.oneMonthReturn,
    required this.oneYearReturn,
    required this.fiveYearReturn,
  });
  factory Fundamentals.fromJson(Map<String, dynamic> json) =>
      _$FundamentalsFromJson(json);

  Map<String, dynamic> toJson() => _$FundamentalsToJson(this);
}

@JsonSerializable()
class DividendsAndSplits {
  final double? dividendYield;

  DividendsAndSplits({
    required this.dividendYield,
  });
  factory DividendsAndSplits.fromJson(Map<String, dynamic> json) =>
      _$DividendsAndSplitsFromJson(json);

  Map<String, dynamic> toJson() => _$DividendsAndSplitsToJson(this);
}

@JsonSerializable()
class Financials {
  final double? profitMargin;
  final double? operatingMargin;
  final double? returnOnAssets;
  final double? returnOnEquity;
  final BalanceSheet? balanceSheet;
  final CashFlow? cashFlow;

  Financials({
    required this.profitMargin,
    required this.operatingMargin,
    required this.returnOnAssets,
    required this.returnOnEquity,
    required this.balanceSheet,
    required this.cashFlow,
  });
  factory Financials.fromJson(Map<String, dynamic> json) =>
      _$FinancialsFromJson(json);

  Map<String, dynamic> toJson() => _$FinancialsToJson(this);
}

@JsonSerializable()
class BalanceSheet {
  final double? debtToEquity;

  BalanceSheet({
    required this.debtToEquity,
  });
  factory BalanceSheet.fromJson(Map<String, dynamic> json) =>
      _$BalanceSheetFromJson(json);

  Map<String, dynamic> toJson() => _$BalanceSheetToJson(this);
}

@JsonSerializable()
class CashFlow {
  final int? operatingCashFlow;

  CashFlow({
    required this.operatingCashFlow,
  });
  factory CashFlow.fromJson(Map<String, dynamic> json) =>
      _$CashFlowFromJson(json);

  Map<String, dynamic> toJson() => _$CashFlowToJson(this);
}

@JsonSerializable()
class Id {
  final int? timestamp;
  final int? date;

  Id({
    required this.timestamp,
    required this.date,
  });
  factory Id.fromJson(Map<String, dynamic> json) => _$IdFromJson(json);

  Map<String, dynamic> toJson() => _$IdToJson(this);
}

@JsonSerializable()
class ValuationsMetrics {
  final int? marketCapitalization;
  final double? priceToEarningsRatio;
  final double? priceToBookRatio;

  ValuationsMetrics({
    required this.marketCapitalization,
    required this.priceToEarningsRatio,
    required this.priceToBookRatio,
  });
  factory ValuationsMetrics.fromJson(Map<String, dynamic> json) =>
      _$ValuationsMetricsFromJson(json);

  Map<String, dynamic> toJson() => _$ValuationsMetricsToJson(this);
}

@JsonSerializable()
class Profile {
  final String? id;
  final String? symbolName;
  final String? name;
  final String? industry;
  final String? sector;
  final String? description;
  final String? website;

  Profile({
    required this.id,
    required this.symbolName,
    required this.name,
    required this.industry,
    required this.sector,
    required this.description,
    required this.website,
  });
  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

@JsonSerializable()
class Quote {
  final String? id;
  final double? open;
  final double? high;
  final double? low;
  final double? close;
  final double? change;
  final double? percentChange;
  final double? previousClose;
  final FiftyTwoWeek fiftyTwoWeek;

  Quote({
    required this.id,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.change,
    required this.percentChange,
    required this.previousClose,
    required this.fiftyTwoWeek,
  });
  factory Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);

  Map<String, dynamic> toJson() => _$QuoteToJson(this);
}

@JsonSerializable()
class FiftyTwoWeek {
  final double? low;
  final double? high;

  FiftyTwoWeek({
    required this.low,
    required this.high,
  });
  factory FiftyTwoWeek.fromJson(Map<String, dynamic> json) =>
      _$FiftyTwoWeekFromJson(json);

  Map<String, dynamic> toJson() => _$FiftyTwoWeekToJson(this);
}
