import 'package:json_annotation/json_annotation.dart';

part 'sell_gold_silver_params.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SellGoldSilverParams {
  final String orderId;

  const SellGoldSilverParams({required this.orderId});

  factory SellGoldSilverParams.fromJson(Map<String, dynamic> json) =>
      _$SellGoldSilverParamsFromJson(json);

  Map<String, dynamic> toJson() => _$SellGoldSilverParamsToJson(this);
}
