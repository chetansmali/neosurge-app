import 'package:json_annotation/json_annotation.dart';

import 'fund.dart';

part 'fund_detail.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class FundDetail {
//   "amc_code": "AMC35",
//         "amc_name": "Sundaram Asset Management Company Limited",
//         "scheme_code": "149532",
//         "scheme_name": "Sundaram Focused Fund-Growth Option",
//         "scheme_name_unique": "Sundaram Focused Fund",
//         "isin": "INF173K01189",
//         "asset_category": "Equity",
//         "asset_sub_category": "Focused",
//         "plan_name": "Broker",
//         "option_name": "Growth",
//         "expense_ratio": 2.56,
//         "risk_rating": 8.5,
//         "rta_name": "KARVY",
//         "scheme_code_bse": "SULCGP-GR",
//         "amc_code_bse": "SUNDARAMMUTUALFUND_M",
//         "vr_rating": "****",
//         "amc_scheme_code_bse": "LCGP",
//         "rta_scheme_code_bse": "LCGP",
//         "scheme_description": "Sundaram Focused Fund-Growth Option",
//         "scheme_description_bse": "SUNDARAM FOCUSED FUND - REGULAR  GROWTH",
//         "investment_option": "Growth",
//         "nature": "Open ended",
//         "active": "Active",
//         "purchase_allowed": "Y",
//         "purchase_transaction_mode": "DP",
//         "min_initial_investment": 300,
//         "initial_investment_multiples": 1,
//         "min_additional_investment": 300,
//         "additional_investment_multiples": 0,
//         "min_withdrawal_amount": 500.0,
//         "sip_allowed": "Y",
//         "sip_frequency": 0.0,
//         "sip_date": "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30",
//         "min_sip_amount": 100,
//         "min_sip_installments": 12,
//         "max_sip_installments": 9999,
//         "sip_multiples": 1,
//         "min_sip_gap": 0,
//         "max_sip_gap": 60,
//         "sip_installment_gap": 0,
//         "sip_status": 1,
//         "switch_allowed": "Y",
//         "switch_min_amt": 300,
//         "switch_multiples": 1,
//         "switch_additional_amt": 300,
//         "stp_allowed": "Y",
//         "stp_frequency": 0,
//         "stp_dates": "",
//         "stp_min_amount": 300,
//         "swp_allowed": "Y",
//         "swp_min_amount": 500.0,
//         "lock_in_period": 0,
//         "risk_profile": "Aggressive",
//         "exit_load_period_remark": "0.25% before 7D, Nil after 7D",
//         "exit_load_rate": 0,
//         "fund_size": 668.8444,
//         "performance": {
//             "oneM": -5.11,
//             "oneY": 0.0,
//             "twoY": 0.0,
//             "threeM": -13.4,
//             "threeY": 0.0,
//             "fiveY": 0.0,
//             "sixM": 0.0,
//             "sevenY": 0.0,
//             "nineM": 0.0,
//             "tenY": 0.0
//         },
//         "img_url": "https://bullsurge.mindstack.in/ff/amclogo/AMC35.png",
//         "benchmark": "Nifty 500 Index",
//         "nav": 93.044,
//         "nav_date": "2022-06-22T00:00:00.000Z",
//         "fund_manager": null,
//         "isin_dividend_payout_or_growth": "INF173K01189",
//         "isin_dividend_reinvest": "",
//         "bse_txn": "Y",
//         "bse_code_payout_or_growth": "SULCGP-GR",
//         "bse_code_reinvest": "",
//         "objective": "The Investment Objective Of The Scheme Would Be To Provide Capital Appreciation And /Or Dividend Distribution By Investing In Companies Across Market Capitalization.",
//         "scheme_doc_urlString": null,
//         "riskometer": "Very High",
//         "exit_load": {
//             "exit_load_period": 0.0,
//             "exit_load_rate": 0.25,
//             "exit_load_period_remark": "0.25% before 7D, Nil after 7D"
//         },
//         "txn_info": {
//             "min_invest": 300.0,
//             "min_invest_sip": 100.0,
//             "min_invest_x": 1.0,
//             "min_invest_sip_x": 1.0
//         }
//     }

  final String amcCode;
  final String amcName;
  final String schemeCode;
  final String schemeName;
  final String schemeNameUnique;
  final String isin;
  final String assetCategory;
  final String assetSubCategory;
  final String planName;
  final String optionName;
  final double expenseRatio;
  final double riskRating;
  final String rtaName;
  final String schemeCodeBse;
  final String amcCodeBse;
  final String vrRating;
  final String amcSchemeCodeBse;
  final String rtaSchemeCodeBse;
  final String schemeDescription;
  final String schemeDescriptionBse;
  final String investmentOption;
  final String nature;
  final String active;
  final String purchaseAllowed;
  final String purchaseTransactionMode;
  final double minInitialInvestment;
  final double initialInvestmentMultiples;
  final double minAdditionalInvestment;
  final double additionalInvestmentMultiples;
  final double minWithdrawalAmount;
  final String sipAllowed;
  final double sipFrequency;
  final String sipDate;
  final double minSipAmount;
  final int minSipInstallments;
  final int maxSipInstallments;
  final double sipMultiples;
  final int minSipGap;
  final int maxSipGap;
  final int sipInstallmentGap;
  final int sipStatus;
  final String switchAllowed;
  final double switchMinAmt;
  final double switchMultiples;
  final double switchAdditionalAmt;
  final String stpAllowed;
  final double stpFrequency;
  final String stpDates;
  final double stpMinAmount;
  final String swpAllowed;
  final double swpMinAmount;
  final int lockInPeriod;
  final String? riskProfile;
  final String exitLoadPeriodRemark;
  final double exitLoadRate;
  final double fundSize;
  final Performance performance;
  final String imgUrl;
  final String benchmark;
  final double nav;
  final DateTime navDate;
  final String? fundManager;
  final String isinDividendPayoutOrGrowth;
  final String isinDividendReinvest;
  final String bseTxn;
  final String bseCodePayoutOrGrowth;
  final String bseCodeReinvest;
  final String objective;
  final String? schemeDocUrlString;
  final String riskometer;
  final ExitLoad exitLoad;
  final TxnInfo txnInfo;

  List<int> get validSipDates =>
      sipDate.split(',').map((e) => int.parse(e)).toList();

  FundDetail({
    required this.amcCode,
    required this.amcName,
    required this.schemeCode,
    required this.schemeName,
    required this.schemeNameUnique,
    required this.isin,
    required this.assetCategory,
    required this.assetSubCategory,
    required this.planName,
    required this.optionName,
    required this.expenseRatio,
    required this.riskRating,
    required this.rtaName,
    required this.schemeCodeBse,
    required this.amcCodeBse,
    required this.vrRating,
    required this.amcSchemeCodeBse,
    required this.rtaSchemeCodeBse,
    required this.schemeDescription,
    required this.schemeDescriptionBse,
    required this.investmentOption,
    required this.nature,
    required this.active,
    required this.purchaseAllowed,
    required this.purchaseTransactionMode,
    required this.minInitialInvestment,
    required this.initialInvestmentMultiples,
    required this.minAdditionalInvestment,
    required this.additionalInvestmentMultiples,
    required this.minWithdrawalAmount,
    required this.sipAllowed,
    required this.sipFrequency,
    required this.sipDate,
    required this.minSipAmount,
    required this.minSipInstallments,
    required this.maxSipInstallments,
    required this.sipMultiples,
    required this.minSipGap,
    required this.maxSipGap,
    required this.sipInstallmentGap,
    required this.sipStatus,
    required this.switchAllowed,
    required this.switchMinAmt,
    required this.switchMultiples,
    required this.switchAdditionalAmt,
    required this.stpAllowed,
    required this.stpFrequency,
    required this.stpDates,
    required this.stpMinAmount,
    required this.swpAllowed,
    required this.swpMinAmount,
    required this.lockInPeriod,
    required this.riskProfile,
    required this.exitLoadPeriodRemark,
    required this.exitLoadRate,
    required this.fundSize,
    required this.performance,
    required this.imgUrl,
    required this.benchmark,
    required this.nav,
    required this.navDate,
    this.fundManager,
    required this.isinDividendPayoutOrGrowth,
    required this.isinDividendReinvest,
    required this.bseTxn,
    required this.bseCodePayoutOrGrowth,
    required this.bseCodeReinvest,
    required this.objective,
    this.schemeDocUrlString,
    required this.riskometer,
    required this.exitLoad,
    required this.txnInfo,
  });

  factory FundDetail.fromJson(Map<String, dynamic> json) =>
      _$FundDetailFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ExitLoad {
  final double exitLoadPeriod;
  final double exitLoadRate;
  final String exitLoadPeriodRemark;

  ExitLoad({
    required this.exitLoadPeriod,
    required this.exitLoadRate,
    required this.exitLoadPeriodRemark,
  });

  factory ExitLoad.fromJson(Map<String, dynamic> json) =>
      _$ExitLoadFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class TxnInfo {
  final double minInvest;
  final double minInvestSip;
  final double minInvestX;
  final double minInvestSipX;

  TxnInfo({
    required this.minInvest,
    required this.minInvestSip,
    required this.minInvestX,
    required this.minInvestSipX,
  });

  factory TxnInfo.fromJson(Map<String, dynamic> json) =>
      _$TxnInfoFromJson(json);
}
