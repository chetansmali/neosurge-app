import 'package:json_annotation/json_annotation.dart';
import 'basket_fund.dart';

part 'basket_details.g.dart';

@JsonSerializable()
class BasketDetailsModel {
  final String name;
  final double cagr;
  @JsonKey(name: 'minSIP')
  final double? minSip;
  final double? minLumpsum;
  final double? aum;
  final String? aboutBasket;
  final List<String> whyInvest;
  final List<BasketFund> basketFunds;
  @JsonKey(name: 'basketID')
  final String? basketId;
  final bool sixM;
  final bool oneY;
  final bool threeY;
  final bool fiveY;
  final String? imageUrl;

  BasketDetailsModel({
    required this.name,
    required this.cagr,
    required this.minSip,
    required this.minLumpsum,
    required this.aum,
    required this.aboutBasket,
    required this.whyInvest,
    required this.basketFunds,
    required this.basketId,
    required this.sixM,
    required this.oneY,
    required this.threeY,
    required this.fiveY,
    required this.imageUrl,
  });

  factory BasketDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$BasketDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$BasketDetailsModelToJson(this);
}
