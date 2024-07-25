import 'package:json_annotation/json_annotation.dart';

part 'fund.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Fund {
  final String amcCode;
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
  final String amcName;
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
  final int initialInvestmentMultiples;
  final double minAdditionalInvestment;
  final int additionalInvestmentMultiples;
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
  final int switchMultiples;
  final double switchAdditionalAmt;
  final String stpAllowed;
  final int stpFrequency;
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
  final String? folioNumber;

  Fund({
    required this.amcCode,
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
    required this.amcName,
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
    this.folioNumber,
  });

  factory Fund.fromJson(Map<String, dynamic> json) => _$FundFromJson(json);

  Map<String, dynamic> toJson() => _$FundToJson(this);

  //fund list from json
  static List<Fund> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((fund) => Fund.fromJson(fund)).toList();
  }
}

@JsonSerializable()
class Performance {
  final double oneM;
  final double oneY;
  final double twoY;
  final double threeM;
  final double threeY;
  final double fiveY;
  final double sixM;
  final double sevenY;
  final double nineM;
  final double tenY;

  Performance({
    required this.oneM,
    required this.oneY,
    required this.twoY,
    required this.threeM,
    required this.threeY,
    required this.fiveY,
    required this.sixM,
    required this.sevenY,
    required this.nineM,
    required this.tenY,
  });

  factory Performance.fromJson(Map<String, dynamic> json) =>
      _$PerformanceFromJson(json);

  Map<String, dynamic> toJson() => _$PerformanceToJson(this);
}
