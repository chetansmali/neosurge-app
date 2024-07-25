import 'package:json_annotation/json_annotation.dart';
part 'remove_alert_params.g.dart';

@JsonSerializable()
class RemoveAlertParams {
  final List<String> alertIds;

  RemoveAlertParams({
    required this.alertIds,
  });
  factory RemoveAlertParams.fromJson(Map<String, dynamic> json) =>
      _$RemoveAlertParamsFromJson(json);

  Map<String, dynamic> toJson() => _$RemoveAlertParamsToJson(this);

  static List<RemoveAlertParams> listFromJson(List<dynamic> json) =>
      json.map((e) => RemoveAlertParams.fromJson(e)).toList();
}
