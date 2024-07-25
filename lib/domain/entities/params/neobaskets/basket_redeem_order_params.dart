import 'package:json_annotation/json_annotation.dart';
part 'basket_redeem_order_params.g.dart';

@JsonSerializable()
class BasketRedeemOrderParams {
  @JsonKey(name: 'basketID')
  final String basketId;
  final String redemptionType;
  final bool isBroken;
  final String? amount;
  final bool? redeemAll;

  BasketRedeemOrderParams({
    required this.basketId,
    required this.redemptionType,
    required this.isBroken,
    this.amount,
    this.redeemAll,
  });

  factory BasketRedeemOrderParams.fromJson(Map<String, dynamic> json) =>
      _$BasketRedeemOrderParamsFromJson(json);

  Map<String, dynamic> toJson() => _$BasketRedeemOrderParamsToJson(this);
}
