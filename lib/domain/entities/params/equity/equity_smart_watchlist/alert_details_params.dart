import 'package:json_annotation/json_annotation.dart';
part 'alert_details_params.g.dart';

@JsonSerializable()
class AlertDetailsParams {
  final String symbol;

  AlertDetailsParams({
    required this.symbol,
  });

  factory AlertDetailsParams.fromJson(Map<String, dynamic> json) =>
      _$AlertDetailsParamsFromJson(json);

  Map<String, dynamic> toJson() => _$AlertDetailsParamsToJson(this);
}
