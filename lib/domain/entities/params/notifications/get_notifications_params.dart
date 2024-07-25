import 'package:json_annotation/json_annotation.dart';

part 'get_notifications_params.g.dart';

@JsonSerializable()
class GetNotificationsParams {
  final int pageNumber;

  GetNotificationsParams({required this.pageNumber});

  factory GetNotificationsParams.fromJson(Map<String, dynamic> json) =>
      _$GetNotificationsParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetNotificationsParamsToJson(this);
}
