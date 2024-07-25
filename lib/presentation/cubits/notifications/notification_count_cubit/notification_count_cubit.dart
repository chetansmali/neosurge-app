import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/notifications/get_unread_notification_count.dart';

@injectable
class NotificationCountCubit extends Cubit<int?> {
  final GetUnreadNotificationCount _getUnreadNotificationCount;

  NotificationCountCubit(this._getUnreadNotificationCount) : super(null);

  void getUnreadNotificationCount() async {
    final result = await _getUnreadNotificationCount(NoParams());
    result.fold((l) => null, (r) => emit(r));
  }

  void subtractOne() {
    if (state != null) {
      emit(state! - 1);
    }
  }

  void setToZero() {
    emit(0);
  }
}
