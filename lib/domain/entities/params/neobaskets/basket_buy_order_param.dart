import 'package:json_annotation/json_annotation.dart';

part 'basket_buy_order_param.g.dart';

@JsonSerializable()
class BasketBuyOrderParam {
  final String? sortBy;

  const BasketBuyOrderParam({
    this.sortBy,
  });

  Map<String, dynamic> toJson() => _$BasketBuyOrderParamToJson(this);

  factory BasketBuyOrderParam.fromJson(Map<String, dynamic> json) =>
      _$BasketBuyOrderParamFromJson(json);
}
