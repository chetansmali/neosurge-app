import 'package:json_annotation/json_annotation.dart';

part 'mutual_fund.g.dart';

@JsonSerializable()
class MutualFund {
  final String schemeCode;
  final String schemeName;
  final double fundSize;
  final double expenseRatio;
  final String assetCategory;
  final String assetSubCategory;
  final String? primarySector;
  final String? imgUrl;
  @JsonKey(name: '_1M')
  final double? oneM;
  @JsonKey(name: '_3M')
  final double? threeM;
  @JsonKey(name: '_6M')
  final double? sixM;
  @JsonKey(name: '_9M')
  final double? nineM;
  @JsonKey(name: '_1Y')
  final double? oneY;
  @JsonKey(name: '_2Y')
  final double? twoY;
  @JsonKey(name: '_3Y')
  final double? threeY;
  @JsonKey(name: '_5Y')
  final double? fiveY;
  @JsonKey(name: '_7Y')
  final double? savenY;
  @JsonKey(name: '_10Y')
  final double? tenY;

  MutualFund({
    required this.schemeCode,
    required this.schemeName,
    required this.fundSize,
    required this.expenseRatio,
    required this.assetCategory,
    required this.assetSubCategory,
    required this.primarySector,
    this.imgUrl,
    this.oneM,
    this.threeM,
    this.sixM,
    this.nineM,
    this.oneY,
    this.twoY,
    this.threeY,
    this.fiveY,
    this.savenY,
    this.tenY,
  });

  factory MutualFund.fromJson(Map<String, dynamic> json) =>
      _$MutualFundFromJson(json);

  Map<String, dynamic> toJson() => _$MutualFundToJson(this);

  static List<MutualFund> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((fund) => MutualFund.fromJson(fund)).toList();
  }
}
