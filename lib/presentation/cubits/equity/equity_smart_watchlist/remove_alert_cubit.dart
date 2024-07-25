import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/equity/equity_smart_watchlist/remove_alert_model.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/equity/equity_smart_watchlist/remove_alert_params.dart';
import '../../../../domain/usecases/equity/remove_alert.dart';

part 'remove_alert_state.dart';

@injectable
class RemoveAlertCubit extends Cubit<RemoveAlertState> {
  final RemoveAlert removeAlert;
  RemoveAlertCubit(this.removeAlert) : super(RemoveAlertInitial());

  Future deleteAlert(RemoveAlertParams params) async {
    emit(RemoveAlertLoading());
    final response = await removeAlert(params);

    response.fold(
        (l) => emit(
            RemoveAlertFailure(errorType: l.errorType, errorMessage: l.error)),
        (r) => emit(RemoveAlertLoaded(r)));
  }
}
