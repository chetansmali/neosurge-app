// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockDetailsModel _$StockDetailsModelFromJson(Map<String, dynamic> json) =>
    StockDetailsModel(
      quote: json['quote'] == null
          ? null
          : Quote.fromJson(json['quote'] as Map<String, dynamic>),
      profile: json['profile'] == null
          ? null
          : Profile.fromJson(json['profile'] as Map<String, dynamic>),
      fundamentals: json['fundamentals'] == null
          ? null
          : Fundamentals.fromJson(json['fundamentals'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StockDetailsModelToJson(StockDetailsModel instance) =>
    <String, dynamic>{
      'quote': instance.quote,
      'profile': instance.profile,
      'fundamentals': instance.fundamentals,
    };

Fundamentals _$FundamentalsFromJson(Map<String, dynamic> json) => Fundamentals(
      id: json['id'] == null
          ? null
          : Id.fromJson(json['id'] as Map<String, dynamic>),
      valuationsMetrics: json['valuationsMetrics'] == null
          ? null
          : ValuationsMetrics.fromJson(
              json['valuationsMetrics'] as Map<String, dynamic>),
      financials: json['financials'] == null
          ? null
          : Financials.fromJson(json['financials'] as Map<String, dynamic>),
      dividendsAndSplits: json['dividendsAndSplits'] == null
          ? null
          : DividendsAndSplits.fromJson(
              json['dividendsAndSplits'] as Map<String, dynamic>),
      oneMonthReturn: (json['oneMonthReturn'] as num?)?.toDouble(),
      oneYearReturn: (json['oneYearReturn'] as num?)?.toDouble(),
      fiveYearReturn: (json['fiveYearReturn'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$FundamentalsToJson(Fundamentals instance) =>
    <String, dynamic>{
      'id': instance.id,
      'valuationsMetrics': instance.valuationsMetrics,
      'financials': instance.financials,
      'dividendsAndSplits': instance.dividendsAndSplits,
      'oneMonthReturn': instance.oneMonthReturn,
      'oneYearReturn': instance.oneYearReturn,
      'fiveYearReturn': instance.fiveYearReturn,
    };

DividendsAndSplits _$DividendsAndSplitsFromJson(Map<String, dynamic> json) =>
    DividendsAndSplits(
      dividendYield: (json['dividendYield'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DividendsAndSplitsToJson(DividendsAndSplits instance) =>
    <String, dynamic>{
      'dividendYield': instance.dividendYield,
    };

Financials _$FinancialsFromJson(Map<String, dynamic> json) => Financials(
      profitMargin: (json['profitMargin'] as num?)?.toDouble(),
      operatingMargin: (json['operatingMargin'] as num?)?.toDouble(),
      returnOnAssets: (json['returnOnAssets'] as num?)?.toDouble(),
      returnOnEquity: (json['returnOnEquity'] as num?)?.toDouble(),
      balanceSheet: json['balanceSheet'] == null
          ? null
          : BalanceSheet.fromJson(json['balanceSheet'] as Map<String, dynamic>),
      cashFlow: json['cashFlow'] == null
          ? null
          : CashFlow.fromJson(json['cashFlow'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FinancialsToJson(Financials instance) =>
    <String, dynamic>{
      'profitMargin': instance.profitMargin,
      'operatingMargin': instance.operatingMargin,
      'returnOnAssets': instance.returnOnAssets,
      'returnOnEquity': instance.returnOnEquity,
      'balanceSheet': instance.balanceSheet,
      'cashFlow': instance.cashFlow,
    };

BalanceSheet _$BalanceSheetFromJson(Map<String, dynamic> json) => BalanceSheet(
      debtToEquity: (json['debtToEquity'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$BalanceSheetToJson(BalanceSheet instance) =>
    <String, dynamic>{
      'debtToEquity': instance.debtToEquity,
    };

CashFlow _$CashFlowFromJson(Map<String, dynamic> json) => CashFlow(
      operatingCashFlow: json['operatingCashFlow'] as int?,
    );

Map<String, dynamic> _$CashFlowToJson(CashFlow instance) => <String, dynamic>{
      'operatingCashFlow': instance.operatingCashFlow,
    };

Id _$IdFromJson(Map<String, dynamic> json) => Id(
      timestamp: json['timestamp'] as int?,
      date: json['date'] as int?,
    );

Map<String, dynamic> _$IdToJson(Id instance) => <String, dynamic>{
      'timestamp': instance.timestamp,
      'date': instance.date,
    };

ValuationsMetrics _$ValuationsMetricsFromJson(Map<String, dynamic> json) =>
    ValuationsMetrics(
      marketCapitalization: json['marketCapitalization'] as int?,
      priceToEarningsRatio: (json['priceToEarningsRatio'] as num?)?.toDouble(),
      priceToBookRatio: (json['priceToBookRatio'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ValuationsMetricsToJson(ValuationsMetrics instance) =>
    <String, dynamic>{
      'marketCapitalization': instance.marketCapitalization,
      'priceToEarningsRatio': instance.priceToEarningsRatio,
      'priceToBookRatio': instance.priceToBookRatio,
    };

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      id: json['id'] as String?,
      symbolName: json['symbolName'] as String?,
      name: json['name'] as String?,
      industry: json['industry'] as String?,
      sector: json['sector'] as String?,
      description: json['description'] as String?,
      website: json['website'] as String?,
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'id': instance.id,
      'symbolName': instance.symbolName,
      'name': instance.name,
      'industry': instance.industry,
      'sector': instance.sector,
      'description': instance.description,
      'website': instance.website,
    };

Quote _$QuoteFromJson(Map<String, dynamic> json) => Quote(
      id: json['id'] as String?,
      open: (json['open'] as num?)?.toDouble(),
      high: (json['high'] as num?)?.toDouble(),
      low: (json['low'] as num?)?.toDouble(),
      close: (json['close'] as num?)?.toDouble(),
      change: (json['change'] as num?)?.toDouble(),
      percentChange: (json['percentChange'] as num?)?.toDouble(),
      previousClose: (json['previousClose'] as num?)?.toDouble(),
      fiftyTwoWeek:
          FiftyTwoWeek.fromJson(json['fiftyTwoWeek'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QuoteToJson(Quote instance) => <String, dynamic>{
      'id': instance.id,
      'open': instance.open,
      'high': instance.high,
      'low': instance.low,
      'close': instance.close,
      'change': instance.change,
      'percentChange': instance.percentChange,
      'previousClose': instance.previousClose,
      'fiftyTwoWeek': instance.fiftyTwoWeek,
    };

FiftyTwoWeek _$FiftyTwoWeekFromJson(Map<String, dynamic> json) => FiftyTwoWeek(
      low: (json['low'] as num?)?.toDouble(),
      high: (json['high'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$FiftyTwoWeekToJson(FiftyTwoWeek instance) =>
    <String, dynamic>{
      'low': instance.low,
      'high': instance.high,
    };
