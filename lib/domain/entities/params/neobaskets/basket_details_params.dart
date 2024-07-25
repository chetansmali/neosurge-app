import 'package:json_annotation/json_annotation.dart';

part 'basket_details_params.g.dart';

@JsonSerializable()
class BasketDetailsParams {
  @JsonKey(name: 'basketID')
  final String basketId;

  BasketDetailsParams({
    required this.basketId,
  });

  factory BasketDetailsParams.fromJson(Map<String, dynamic> json) =>
      _$BasketDetailsParamsFromJson(json);

  Map<String, dynamic> toJson() => _$BasketDetailsParamsToJson(this);
}
