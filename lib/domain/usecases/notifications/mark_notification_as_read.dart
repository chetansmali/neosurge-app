import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/notifications/notification_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/notification_repository.dart';

@injectable
class MarkNotificationAsRead extends UseCase<void, NotificationParams> {
  final NotificationRepository _notificationRepository;

  MarkNotificationAsRead(this._notificationRepository);

  @override
  Future<Either<AppError, void>> call(params) =>
      _notificationRepository.markNotificationAsRead(params.toJson());
}
