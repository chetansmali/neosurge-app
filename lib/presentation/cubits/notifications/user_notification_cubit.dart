
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/user/user_notification.dart';
import '../../../domain/entities/app_error.dart';
import '../../../domain/entities/params/notifications/get_notifications_params.dart';
import '../../../domain/usecases/notifications/get_user_notifications.dart';

part 'user_notification_state.dart';

@injectable
class UserNotificationCubit extends Cubit<UserNotificationState> {
  final GetUserNotifications _getUserNotifications;

  UserNotificationCubit(this._getUserNotifications)
      : super(UserNotificationInitial());

  int _page = 1;
  final int _fetchLimit = 10; // Is the limit set by the server

  void fetchUserNotifications() async {
    if (state is UserNotificationLoading) return;
    List<UserNotification> oldNotifications = [];
    final currentState = state;
    if (currentState is UserNotificationLoaded) {
      oldNotifications = currentState.notifications;
    } else if (currentState is UserNotificationLoadError) {
      oldNotifications = currentState.oldNotifications;
    }

    emit(UserNotificationLoading(
        isFirstFetch: _page == 1, oldNotifications: oldNotifications));
    final result =
        await _getUserNotifications(GetNotificationsParams(pageNumber: _page));
    result.fold(
      (l) => emit(UserNotificationLoadError(
          error: l.error,
          errorType: l.errorType,
          isFirstFetch: _page == 1,
          oldNotifications: oldNotifications)),
      (r) {
        oldNotifications.addAll(r);
        if (r.length < _fetchLimit) {
          emit(UserNotificationLoaded(
              isLastPage: true, notifications: oldNotifications));
        } else {
          _page++;
          emit(UserNotificationLoaded(
            notifications: oldNotifications,
          ));
        }
      },
    );
  }

  void markNotificationAsRead(int index) {
    final currState = state as UserNotificationLoaded;
    final notifications = List<UserNotification>.from(currState.notifications);
    final bool isLastPage = currState.isLastPage;
    notifications[index] = notifications[index].copyWith(isRead: true);
    emit(UserNotificationLoaded(
        notifications: notifications, isLastPage: isLastPage));
  }

  void markAllNotificationsAsRead() {
    final notifications = (state as UserNotificationLoaded).notifications;
    final newNotifications = notifications
        .map((notification) => notification.copyWith(isRead: true))
        .toList();
    emit(UserNotificationLoaded(notifications: newNotifications));
  }
}
