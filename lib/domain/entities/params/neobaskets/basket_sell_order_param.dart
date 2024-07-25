import 'package:json_annotation/json_annotation.dart';

part 'basket_sell_order_param.g.dart';

@JsonSerializable()
class BasketSellOrderParam {
  final String? sortBy;

  const BasketSellOrderParam({
    this.sortBy,
  });

  Map<String, dynamic> toJson() => _$BasketSellOrderParamToJson(this);

  factory BasketSellOrderParam.fromJson(Map<String, dynamic> json) =>
      _$BasketSellOrderParamFromJson(json);
}
