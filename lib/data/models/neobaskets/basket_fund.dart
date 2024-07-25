import 'package:json_annotation/json_annotation.dart';

part 'basket_fund.g.dart';

@JsonSerializable()
class BasketFund {
  int id;
  @JsonKey(name: 'basketID')
  String? basketId;
  String? fundName;
  String? schemeCode;
  double? aum;
  double? cagr;
  String? amc;
  double? exitLoad;
  double? allocationPercentage;
  String? fundCategory;
  double? returns;
  @JsonKey(name: 'logoURL')
  String? logoUrl;
  double? minSip;
  double? minLumpsum;
  String? amcCode;
  String? isin;

  BasketFund({
    required this.id,
    required this.basketId,
    required this.fundName,
    required this.schemeCode,
    required this.aum,
    required this.cagr,
    required this.amc,
    required this.exitLoad,
    required this.allocationPercentage,
    required this.fundCategory,
    required this.returns,
    required this.logoUrl,
    required this.minSip,
    required this.minLumpsum,
    required this.amcCode,
    required this.isin,
  });

  factory BasketFund.fromJson(Map<String, dynamic> json) =>
      _$BasketFundFromJson(json);

  Map<String, dynamic> toJson() => _$BasketFundToJson(this);
}
