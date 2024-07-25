part of 'user_notification_cubit.dart';

abstract class UserNotificationState extends Equatable {
  const UserNotificationState();
}

class UserNotificationInitial extends UserNotificationState {
  @override
  List<Object> get props => [];
}

class UserNotificationLoading extends UserNotificationState {
  final List<UserNotification> oldNotifications;
  final bool isFirstFetch;

  const UserNotificationLoading({this.oldNotifications = const [], this.isFirstFetch = false});

  @override
  List<Object> get props => [oldNotifications, isFirstFetch];
}

class UserNotificationLoaded extends UserNotificationState {
  final List<UserNotification> notifications;
  final bool isLastPage;

  bool get containsUnread => notifications.any((notification) => !notification.isRead);

  const UserNotificationLoaded({required this.notifications, this.isLastPage = false});

  @override
  List<Object> get props => [notifications, isLastPage];
}

class UserNotificationLoadError extends UserNotificationState {
  final bool isFirstFetch;
  final List<UserNotification> oldNotifications;
  final String? error;
  final AppErrorType errorType;

  const UserNotificationLoadError({required this.error, required this.errorType, this.isFirstFetch = false, this.oldNotifications = const []});

  @override
  List<Object?> get props => [error, errorType, isFirstFetch, oldNotifications];
}
