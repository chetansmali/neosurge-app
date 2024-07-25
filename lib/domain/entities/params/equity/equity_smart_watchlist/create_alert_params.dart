import 'package:json_annotation/json_annotation.dart';
part 'create_alert_params.g.dart';

@JsonSerializable()
class CreateAlertParams {
  final String symbol;
  final double price;
  final String comparisonMetric;

  CreateAlertParams({
    required this.symbol,
    required this.price,
    required this.comparisonMetric,
  });

  factory CreateAlertParams.fromJson(Map<String, dynamic> json) =>
      _$CreateAlertParamsFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAlertParamsToJson(this);
}
