part of 'notification_action_cubit.dart';

abstract class NotificationActionState extends Equatable {
  const NotificationActionState();
}

class NotificationActionInitial extends NotificationActionState {
  @override
  List<Object> get props => [];
}

class NotificationActionLoading extends NotificationActionState {
  @override
  List<Object> get props => [];
}

class NotificationActionSuccess extends NotificationActionState {
  final int? index;
  final bool isAllRead;

  const NotificationActionSuccess({this.index, this.isAllRead = false});

  @override
  List<Object?> get props => [index];
}

class NotificationActionError extends NotificationActionState {
  final String? error;
  final AppErrorType errorType;

  const NotificationActionError({required this.error, required this.errorType});

  @override
  List<Object?> get props => [error, errorType];
}
