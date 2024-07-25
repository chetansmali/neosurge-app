import 'package:json_annotation/json_annotation.dart';
part 'stock_chart.g.dart';

@JsonSerializable()
class StockChartModel{
  //  @JsonKey(fromJson: double.parse)
  final DateTime datetime;
  @JsonKey(fromJson: double.parse)
  final double close;

  StockChartModel({
    required this.datetime,
    required this.close
});

  factory StockChartModel.fromJson(Map<String, dynamic> json) =>
      _$StockChartModelFromJson(json);

  Map<String,dynamic> toJson() =>
      _$StockChartModelToJson(this);

  static List<StockChartModel> listFromJson(List<dynamic> json) =>
      json.map((e) => StockChartModel.fromJson(e)).toList();
}