import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/notification_repository.dart';

@injectable
class GetUnreadNotificationCount extends UseCase<int, NoParams> {
  final NotificationRepository _notificationRepository;

  GetUnreadNotificationCount(this._notificationRepository);

  @override
  Future<Either<AppError, int>> call(NoParams params) =>
      _notificationRepository.getUnreadNotificationCount();
}
