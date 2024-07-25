import 'package:json_annotation/json_annotation.dart';

part 'stock_chart_params.g.dart';

@JsonSerializable()
class StockChartParams{
  final String filter;
  final String symbolName;

  StockChartParams({
    required this.filter,
    required this.symbolName
});
  factory StockChartParams.fromJson(Map<String,dynamic> json) =>
      _$StockChartParamsFromJson(json);

  Map<String,dynamic> toJson() => _$StockChartParamsToJson(this);
}