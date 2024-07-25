import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/notification_repository.dart';

@injectable
class MarkAllNotificationsAsRead extends UseCase<void, NoParams> {
  final NotificationRepository _notificationRepository;

  MarkAllNotificationsAsRead(this._notificationRepository);

  @override
  Future<Either<AppError, void>> call(params) =>
      _notificationRepository.markAllNotificationsAsRead();
}
