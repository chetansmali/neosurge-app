import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/user/user_notification.dart';
import '../../entities/app_error.dart';
import '../../entities/params/notifications/get_notifications_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/notification_repository.dart';

@injectable
class GetUserNotifications
    extends UseCase<List<UserNotification>, GetNotificationsParams> {
  final NotificationRepository _notificationRepository;

  GetUserNotifications(this._notificationRepository);

  @override
  Future<Either<AppError, List<UserNotification>>> call(
          GetNotificationsParams params) =>
      _notificationRepository.getUserNotifications(params.toJson());
}
