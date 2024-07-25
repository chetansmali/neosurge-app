import 'package:json_annotation/json_annotation.dart';

part 'basket_order_params.g.dart';

@JsonSerializable(
  includeIfNull: false,
)
class BasketOrderParams {
  @JsonKey(name: 'basketID')
  final String basketId;
  final int amount;
  @JsonKey(name: 'invDate')
  final String? monthlyInvDate;
  final int? installments;

  BasketOrderParams({
    required this.basketId,
    required this.amount,
    this.monthlyInvDate,
    this.installments,
  });

  factory BasketOrderParams.fromJson(Map<String, dynamic> json) =>
      _$BasketOrderParamsFromJson(json);

  Map<String, dynamic> toJson() => _$BasketOrderParamsToJson(this);
}
