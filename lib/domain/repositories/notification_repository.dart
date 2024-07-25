import 'package:dartz/dartz.dart';

import '../../data/models/user/user_notification.dart';
import '../entities/app_error.dart';

abstract class NotificationRepository {
  Future<Either<AppError, List<UserNotification>>> getUserNotifications(
      Map<String, dynamic> params);

  Future<Either<AppError, void>> markAllNotificationsAsRead();

  Future<Either<AppError, void>> markNotificationAsRead(
      Map<String, dynamic> params);

  Future<Either<AppError, int>> getUnreadNotificationCount();
}
