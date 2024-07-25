import 'package:json_annotation/json_annotation.dart';

part 'basket_buy_transaction_params.g.dart';

@JsonSerializable()
class BasketBuyTransactionParams {
  @JsonKey(name: 'basketID')
  final String basketId;
  final String? sortBy;

  BasketBuyTransactionParams({
    required this.basketId,
    this.sortBy,
  });

  factory BasketBuyTransactionParams.fromJson(Map<String, dynamic> json) =>
      _$BasketBuyTransactionParamsFromJson(json);

  Map<String, dynamic> toJson() => _$BasketBuyTransactionParamsToJson(this);
}
