import 'package:json_annotation/json_annotation.dart';

import '../../../../data/models/user/user_notification.dart';

part 'notification_params.g.dart';

@JsonSerializable()
class NotificationParams {
  /// [id] is the id of the notification in [UserNotification] object.
  final int id;

  const NotificationParams({
    required this.id,
  });

  factory NotificationParams.fromJson(Map<String, dynamic> json) =>
      _$NotificationParamsFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationParamsToJson(this);
}
