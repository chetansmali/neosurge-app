import 'package:json_annotation/json_annotation.dart';

part 'get_basket_chart_params.g.dart';

@JsonSerializable()
class GetBasketChartParams {
  @JsonKey(name: 'basketID')
  final String basketId;
  final String duration;

  GetBasketChartParams({
    required this.basketId,
    required this.duration,
  });

  factory GetBasketChartParams.fromJson(Map<String, dynamic> json) =>
      _$GetBasketChartParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetBasketChartParamsToJson(this);
}
