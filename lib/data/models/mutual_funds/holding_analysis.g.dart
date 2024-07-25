// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'holding_analysis.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HoldingAnalysis _$HoldingAnalysisFromJson(Map<String, dynamic> json) =>
    HoldingAnalysis(
      marketCap: MarketCap.fromJson(json['market_cap'] as Map<String, dynamic>),
      yieldToMaturity: (json['yield_to_maturity'] as num).toDouble(),
      averageMaturity: AverageMaturity.fromJson(
          json['average_maturity'] as Map<String, dynamic>),
      modifiedDuration: ModifiedDuration.fromJson(
          json['modified_duration'] as Map<String, dynamic>),
      peRatio: (json['pe_ratio'] as num).toDouble(),
      portfolioTurnoverRatio:
          (json['portfolio_turnover_ratio'] as num).toDouble(),
      assetBreakUp:
          AssetBreakUp.fromJson(json['asset_break_up'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HoldingAnalysisToJson(HoldingAnalysis instance) =>
    <String, dynamic>{
      'market_cap': instance.marketCap,
      'yield_to_maturity': instance.yieldToMaturity,
      'average_maturity': instance.averageMaturity,
      'modified_duration': instance.modifiedDuration,
      'pe_ratio': instance.peRatio,
      'portfolio_turnover_ratio': instance.portfolioTurnoverRatio,
      'asset_break_up': instance.assetBreakUp,
    };

MarketCap _$MarketCapFromJson(Map<String, dynamic> json) => MarketCap(
      marketCapLarge: (json['market_cap_large'] as num).toDouble(),
      marketCapMid: (json['market_cap_mid'] as num).toDouble(),
      marketCapOthers: (json['market_cap_others'] as num).toDouble(),
      marketCapSmall: (json['market_cap_small'] as num).toDouble(),
    );

Map<String, dynamic> _$MarketCapToJson(MarketCap instance) => <String, dynamic>{
      'market_cap_large': instance.marketCapLarge,
      'market_cap_mid': instance.marketCapMid,
      'market_cap_others': instance.marketCapOthers,
      'market_cap_small': instance.marketCapSmall,
    };

AverageMaturity _$AverageMaturityFromJson(Map<String, dynamic> json) =>
    AverageMaturity(
      avgMaturityDays: (json['avg_maturity_days'] as num).toDouble(),
      avgMaturityMonths: (json['avg_maturity_months'] as num).toDouble(),
      avgMaturityYears: (json['avg_maturity_years'] as num).toDouble(),
    );

Map<String, dynamic> _$AverageMaturityToJson(AverageMaturity instance) =>
    <String, dynamic>{
      'avg_maturity_days': instance.avgMaturityDays,
      'avg_maturity_months': instance.avgMaturityMonths,
      'avg_maturity_years': instance.avgMaturityYears,
    };

ModifiedDuration _$ModifiedDurationFromJson(Map<String, dynamic> json) =>
    ModifiedDuration(
      modifiedMaturityDays: (json['modified_maturity_days'] as num).toDouble(),
      modifiedMaturityMonths:
          (json['modified_maturity_months'] as num).toDouble(),
      modifiedMaturityYears:
          (json['modified_maturity_years'] as num).toDouble(),
    );

Map<String, dynamic> _$ModifiedDurationToJson(ModifiedDuration instance) =>
    <String, dynamic>{
      'modified_maturity_days': instance.modifiedMaturityDays,
      'modified_maturity_months': instance.modifiedMaturityMonths,
      'modified_maturity_years': instance.modifiedMaturityYears,
    };

AssetBreakUp _$AssetBreakUpFromJson(Map<String, dynamic> json) => AssetBreakUp(
      billsRediscounting: (json['bills_rediscounting'] as num).toDouble(),
      cashEquivalent: (json['cash_equivalent'] as num).toDouble(),
      cashManagementBill: (json['cash_management_bill'] as num).toDouble(),
      certificateOfDeposit: (json['certificate_of_deposit'] as num).toDouble(),
      commercialPaper: (json['commercial_paper'] as num).toDouble(),
      corporateDebt: (json['corporate_debt'] as num).toDouble(),
      deposits: (json['deposits'] as num).toDouble(),
      derivatives: (json['derivatives'] as num).toDouble(),
      equity: (json['equity'] as num).toDouble(),
      floatingRateInstruments:
          (json['floating_rate_instruments'] as num).toDouble(),
      governmentSecurities: (json['government_securities'] as num).toDouble(),
      mutualFundUnits: (json['mutual_fund_units'] as num).toDouble(),
      preferenceShares: (json['preference_shares'] as num).toDouble(),
      ptcSecuritizedDebt: (json['ptc_securitized_debt'] as num).toDouble(),
      reitsInvits: (json['reits_invits'] as num).toDouble(),
      treasuryBills: (json['treasury_bills'] as num).toDouble(),
    );

Map<String, dynamic> _$AssetBreakUpToJson(AssetBreakUp instance) =>
    <String, dynamic>{
      'bills_rediscounting': instance.billsRediscounting,
      'cash_equivalent': instance.cashEquivalent,
      'cash_management_bill': instance.cashManagementBill,
      'certificate_of_deposit': instance.certificateOfDeposit,
      'commercial_paper': instance.commercialPaper,
      'corporate_debt': instance.corporateDebt,
      'deposits': instance.deposits,
      'derivatives': instance.derivatives,
      'equity': instance.equity,
      'floating_rate_instruments': instance.floatingRateInstruments,
      'government_securities': instance.governmentSecurities,
      'mutual_fund_units': instance.mutualFundUnits,
      'preference_shares': instance.preferenceShares,
      'ptc_securitized_debt': instance.ptcSecuritizedDebt,
      'reits_invits': instance.reitsInvits,
      'treasury_bills': instance.treasuryBills,
    };
