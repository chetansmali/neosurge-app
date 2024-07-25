import 'package:json_annotation/json_annotation.dart';

part 'fund_holding.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class FundHolding {
  // {
  //             "market_value": 629.19,
  //             "as_on_date": "2022-01",
  //             "security": "4.7% Government of India (22/09/2033)",
  //             "quantity": 62662000,
  //             "coupon": 0,
  //             "agency": "",
  //             "holding_perc": 4.62,
  //             "mkt_cap_category": "",
  //             "rating": "Sovereign",
  //             "sector": "Govt-Sec",
  //             "equiv_rating": "Sovereign",
  //             "isin_security": "IN0020200120"
  //         },
  final double marketValue;
  final String asOnDate;
  final String security;
  final int quantity;
  final double coupon;
  final String agency;
  final double holdingPerc;
  final String mktCapCategory;
  final String rating;
  final String sector;
  final String equivRating;
  final String isinSecurity;

  FundHolding({
    required this.marketValue,
    required this.asOnDate,
    required this.security,
    required this.quantity,
    required this.coupon,
    required this.agency,
    required this.holdingPerc,
    required this.mktCapCategory,
    required this.rating,
    required this.sector,
    required this.equivRating,
    required this.isinSecurity,
  });

  factory FundHolding.fromJson(Map<String, dynamic> json) =>
      _$FundHoldingFromJson(json);

  Map<String, dynamic> toJson() => _$FundHoldingToJson(this);

  //to list of fund holdings
  static List<FundHolding> listFromJson(List<dynamic> json) {
    return json.map((value) => FundHolding.fromJson(value)).toList();
  }
}
