import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/api/api_call_with_error.dart';
import '../../domain/entities/app_error.dart';
import '../../domain/repositories/notification_repository.dart';
import '../data_sources/remote/notification_remote_data_source.dart';
import '../models/user/user_notification.dart';

@LazySingleton(as: NotificationRepository)
class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource _notificationRemoteDataSource;

  NotificationRepositoryImpl(this._notificationRemoteDataSource);

  @override
  Future<Either<AppError, List<UserNotification>>> getUserNotifications(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _notificationRemoteDataSource.getUserNotifications(params));
  }

  @override
  Future<Either<AppError, void>> markAllNotificationsAsRead() {
    return ApiCallWithError.call(
        () => _notificationRemoteDataSource.markAllNotificationsAsRead());
  }

  @override
  Future<Either<AppError, void>> markNotificationAsRead(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _notificationRemoteDataSource.markNotificationAsRead(params));
  }

  @override
  Future<Either<AppError, int>> getUnreadNotificationCount() {
    return ApiCallWithError.call(
        () => _notificationRemoteDataSource.getUnreadNotificationCount());
  }
}
