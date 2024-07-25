import 'package:json_annotation/json_annotation.dart';
part 'basket_portfolio_detail_response.g.dart';

@JsonSerializable()
class BasketPortfolioDetailResponse {
  final double? basketInvestedValue;
  final double? basketCurrentValue;
  final double? basketReturnsValue;
  final double? basketReturnsPercentage;
  final String basketID;
  final String? basketState;
  final String? basketName;
  final String? imageUrl;
  final List<Sip>? sip;
  final List<Fund> funds;

  BasketPortfolioDetailResponse({
    required this.basketInvestedValue,
    required this.basketCurrentValue,
    required this.basketReturnsValue,
    required this.basketReturnsPercentage,
    required this.basketID,
    required this.basketState,
    required this.basketName,
    required this.imageUrl,
    required this.sip,
    required this.funds,
  });

  factory BasketPortfolioDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$BasketPortfolioDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BasketPortfolioDetailResponseToJson(this);
}

@JsonSerializable()
class Sip {
  final double amount;
  final String investmentDate;
  final String sipEnd;
  final String orderRef;

  Sip({
    required this.amount,
    required this.investmentDate,
    required this.sipEnd,
    required this.orderRef,
  });

  factory Sip.fromJson(Map<String, dynamic> json) => _$SipFromJson(json);

  Map<String, dynamic> toJson() => _$SipToJson(this);
}

@JsonSerializable()
class Fund {
  final String fundIsin;
  final String fundName;
  final String logoUrl;
  final double current;
  final double invested;
  final double returns;
  final double? returnsPercentage;
  final String folioNumber;
  final double units;
  final double avgNav;
  final double allocationPercentage;
  final double maxRedeemAmount;
  final double maxRedeemUnit;

  Fund({
    required this.fundIsin,
    required this.fundName,
    required this.logoUrl,
    required this.current,
    required this.invested,
    required this.returns,
    required this.returnsPercentage,
    required this.folioNumber,
    required this.units,
    required this.avgNav,
    required this.allocationPercentage,
    required this.maxRedeemAmount,
    required this.maxRedeemUnit,
  });

  factory Fund.fromJson(Map<String, dynamic> json) => _$FundFromJson(json);

  Map<String, dynamic> toJson() => _$FundToJson(this);
}
