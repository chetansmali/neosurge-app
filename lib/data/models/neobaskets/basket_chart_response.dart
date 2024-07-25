import 'package:fl_chart/fl_chart.dart';
import 'package:json_annotation/json_annotation.dart';

part 'basket_chart_response.g.dart';

@JsonSerializable()
class BasketChartResponse {
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<FlSpot>? basketChartDataList;

  @JsonKey(name: 'possibleValue')
  double? returns;

  BasketChartResponse({
    this.basketChartDataList,
    required this.returns,
  });

  factory BasketChartResponse.fromJson(Map<String, dynamic> json) =>
      _$BasketChartResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BasketChartResponseToJson(this);
}
