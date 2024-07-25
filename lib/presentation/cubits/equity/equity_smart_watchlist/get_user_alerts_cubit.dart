import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/equity/equity_smart_watchlist/get_users_alert.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/equity/equity_smart_watchlist/get_users_alert_params.dart';
import '../../../../domain/usecases/equity/get_users_alerts.dart';

part 'get_user_alerts_state.dart';

@injectable
class GetUserAlertsCubit extends Cubit<GetUserAlertsState> {
  final GetUsersAlerts _getUsersAlerts;
  GetUserAlertsCubit(this._getUsersAlerts) : super(GetUserAlertsInitial());

  Future fetchUserAlerts(GetUsersAlertParams params) async {
    emit(GetUserAlertsLoading());
    final response = await _getUsersAlerts(params);
    response.fold(
        (l) => emit(GetUserAlertsFailure(
            errorType: l.errorType, errorMessage: l.error)),
        (r) => emit(GetUserAlertsLoaded(r)));
  }
}
