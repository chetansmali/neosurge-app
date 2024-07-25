import 'package:json_annotation/json_annotation.dart';

part 'basket_individual_redeem_params.g.dart';

@JsonSerializable()
class BasketIndividualRedeemParams {
  const BasketIndividualRedeemParams({
    required this.basketId,
    required this.schemeId,
    required this.amount,
    required this.units,
    required this.fullRedeem,
  });

  @JsonKey(name: 'basketID')
  final String basketId;
  @JsonKey(name: 'schemeID')
  final String schemeId;
  final double? amount;
  final double? units;
  final bool fullRedeem;

  Map<String, dynamic> toJson() => _$BasketIndividualRedeemParamsToJson(this);

  factory BasketIndividualRedeemParams.fromJson(Map<String, dynamic> json) =>
      _$BasketIndividualRedeemParamsFromJson(json);
}
