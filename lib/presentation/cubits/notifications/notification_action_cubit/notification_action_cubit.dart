import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/user/user_notification.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/entities/params/notifications/notification_params.dart';
import '../../../../domain/usecases/notifications/mark_all_notifcations_as_read.dart';
import '../../../../domain/usecases/notifications/mark_notification_as_read.dart';
import '../../util_cubits/loading_cubit.dart';

part 'notification_action_state.dart';

/// The [NotificationActionCubit] is a [Cubit] that manages the [NotificationActionState].
/// It is used to mark a notification as read or mark all notifications as read.
@injectable
class NotificationActionCubit extends Cubit<NotificationActionState> {
  final LoadingCubit _loadingCubit;
  final MarkNotificationAsRead _markNotificationAsRead;
  final MarkAllNotificationsAsRead _markAllNotificationsAsRead;

  NotificationActionCubit(this._loadingCubit, this._markNotificationAsRead, this._markAllNotificationsAsRead) : super(NotificationActionInitial());

  void markNotificationAsRead(int index, UserNotification notification) async {
    _loadingCubit.show();
    emit(NotificationActionLoading());
    final res = await _markNotificationAsRead(NotificationParams(id: notification.id));
    emit(res.fold((l) => NotificationActionError(error: l.error, errorType: l.errorType), (r) => NotificationActionSuccess(index: index)));
    _loadingCubit.hide();
  }

  void markAllNotificationsAsRead() async {
    _loadingCubit.show();
    emit(NotificationActionLoading());
    final res = await _markAllNotificationsAsRead(NoParams());
    emit(res.fold((l) => NotificationActionError(error: l.error, errorType: l.errorType), (r) => const NotificationActionSuccess(index: null, isAllRead: true)));
    _loadingCubit.hide();
  }
}
