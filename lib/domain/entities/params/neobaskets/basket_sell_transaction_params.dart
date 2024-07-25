import 'package:json_annotation/json_annotation.dart';

part 'basket_sell_transaction_params.g.dart';

@JsonSerializable()
class BasketSellTransactionParams {
  @JsonKey(name: 'basketID')
  final String basketId;
  final String? sortBy;

  BasketSellTransactionParams({
    required this.basketId,
    this.sortBy,
  });

  factory BasketSellTransactionParams.fromJson(Map<String, dynamic> json) =>
      _$BasketSellTransactionParamsFromJson(json);

  Map<String, dynamic> toJson() => _$BasketSellTransactionParamsToJson(this);
}
