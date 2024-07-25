import 'package:json_annotation/json_annotation.dart';

part 'user_notification.g.dart';

@JsonSerializable()
class UserNotification {
  final int id;
  @JsonKey(name: 'notificationSubject')
  final String title;
  @JsonKey(name: 'notificationText')
  final String body;
  final bool isRead;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
  });

  UserNotification copyWith({
    bool? isRead,
  }) =>
      UserNotification(
        id: id,
        title: title,
        body: body,
        isRead: isRead ?? this.isRead,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  factory UserNotification.fromJson(Map<String, dynamic> json) =>
      _$UserNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$UserNotificationToJson(this);
}
