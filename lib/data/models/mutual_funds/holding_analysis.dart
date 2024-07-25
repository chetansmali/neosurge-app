import 'package:flutter/material.dart' show Color;
import 'package:json_annotation/json_annotation.dart';

import '../../../presentation/theme/app_colors.dart';

part 'holding_analysis.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class HoldingAnalysis {
  final MarketCap marketCap;
  final double yieldToMaturity;
  final AverageMaturity averageMaturity;
  final ModifiedDuration modifiedDuration;
  final double peRatio;
  final double portfolioTurnoverRatio;
  final AssetBreakUp assetBreakUp;

  HoldingAnalysis({
    required this.marketCap,
    required this.yieldToMaturity,
    required this.averageMaturity,
    required this.modifiedDuration,
    required this.peRatio,
    required this.portfolioTurnoverRatio,
    required this.assetBreakUp,
  });

  factory HoldingAnalysis.fromJson(Map<String, dynamic> json) =>
      _$HoldingAnalysisFromJson(json);

  Map<String, dynamic> toJson() => _$HoldingAnalysisToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MarketCap {
  final double marketCapLarge;
  final double marketCapMid;
  final double marketCapOthers;
  final double marketCapSmall;

  MarketCap({
    required this.marketCapLarge,
    required this.marketCapMid,
    required this.marketCapOthers,
    required this.marketCapSmall,
  });

  double get totalMarketCap =>
      marketCapLarge + marketCapMid + marketCapOthers + marketCapSmall;

  factory MarketCap.fromJson(Map<String, dynamic> json) =>
      _$MarketCapFromJson(json);

  Map<String, dynamic> toJson() => _$MarketCapToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class AverageMaturity {
  final double avgMaturityDays;
  final double avgMaturityMonths;
  final double avgMaturityYears;

  AverageMaturity({
    required this.avgMaturityDays,
    required this.avgMaturityMonths,
    required this.avgMaturityYears,
  });

  factory AverageMaturity.fromJson(Map<String, dynamic> json) =>
      _$AverageMaturityFromJson(json);

  Map<String, dynamic> toJson() => _$AverageMaturityToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ModifiedDuration {
  final double modifiedMaturityDays;
  final double modifiedMaturityMonths;
  final double modifiedMaturityYears;

  ModifiedDuration({
    required this.modifiedMaturityDays,
    required this.modifiedMaturityMonths,
    required this.modifiedMaturityYears,
  });

  factory ModifiedDuration.fromJson(Map<String, dynamic> json) =>
      _$ModifiedDurationFromJson(json);

  Map<String, dynamic> toJson() => _$ModifiedDurationToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class AssetBreakUp {
  final double billsRediscounting;
  final double cashEquivalent;
  final double cashManagementBill;
  final double certificateOfDeposit;
  final double commercialPaper;
  final double corporateDebt;
  final double deposits;
  final double derivatives;
  final double equity;
  final double floatingRateInstruments;
  final double governmentSecurities;
  final double mutualFundUnits;
  final double preferenceShares;
  final double ptcSecuritizedDebt;
  final double reitsInvits;
  final double treasuryBills;

  List<String> get assetTitles => ['Equity', 'Debt', 'Cash', 'Others'];

  List<double> get assetPercent => [
        equity,
        corporateDebt,
        cashEquivalent,
        //get sum of others except equity, corporateDebt, cashEquivalent
        (billsRediscounting +
            cashManagementBill +
            certificateOfDeposit +
            commercialPaper +
            deposits +
            derivatives +
            floatingRateInstruments +
            governmentSecurities +
            mutualFundUnits +
            preferenceShares +
            ptcSecuritizedDebt +
            reitsInvits +
            treasuryBills)
      ];

  List<Color> get assetColors => [
        AppColors.primaryColor,
        AppColors.yellowPrimary,
        AppColors.chartGreen,
        AppColors.darkOrange,
      ];

  AssetBreakUp({
    required this.billsRediscounting,
    required this.cashEquivalent,
    required this.cashManagementBill,
    required this.certificateOfDeposit,
    required this.commercialPaper,
    required this.corporateDebt,
    required this.deposits,
    required this.derivatives,
    required this.equity,
    required this.floatingRateInstruments,
    required this.governmentSecurities,
    required this.mutualFundUnits,
    required this.preferenceShares,
    required this.ptcSecuritizedDebt,
    required this.reitsInvits,
    required this.treasuryBills,
  });

  factory AssetBreakUp.fromJson(Map<String, dynamic> json) =>
      _$AssetBreakUpFromJson(json);

  Map<String, dynamic> toJson() => _$AssetBreakUpToJson(this);
}
