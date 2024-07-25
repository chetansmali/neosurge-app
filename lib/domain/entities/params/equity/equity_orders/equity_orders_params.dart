import 'package:json_annotation/json_annotation.dart';
part 'equity_orders_params.g.dart';

@JsonSerializable(includeIfNull: false)
class EquityOrdersParams {
  final String email;
  final String timePeriod;
  final String status;
  final String? instrumentType;

  EquityOrdersParams({
    required this.email,
    required this.timePeriod,
    required this.status,
    this.instrumentType,
  });
  factory EquityOrdersParams.fromJson(Map<String, dynamic> json) =>
      _$EquityOrdersParamsFromJson(json);

  Map<String, dynamic> toJson() => _$EquityOrdersParamsToJson(this);
}
