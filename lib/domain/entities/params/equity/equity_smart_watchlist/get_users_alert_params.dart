import 'package:json_annotation/json_annotation.dart';
part 'get_users_alert_params.g.dart';

@JsonSerializable()
class GetUsersAlertParams {
  final int page;
  final int size;
  final String sort;

  GetUsersAlertParams(
      {required this.page, required this.size, required this.sort});

  factory GetUsersAlertParams.fromJson(Map<String, dynamic> json) =>
      _$GetUsersAlertParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetUsersAlertParamsToJson(this);
}
