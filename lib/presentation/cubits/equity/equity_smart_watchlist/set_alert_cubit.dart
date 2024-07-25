import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/equity/equity_smart_watchlist/create_alert_model.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/equity/equity_smart_watchlist/create_alert_params.dart';
import '../../../../domain/usecases/equity/set_alert.dart';

part 'set_alert_state.dart';

@injectable
class SetAlertCubit extends Cubit<SetAlertState> {
  final SetAlert _setAlert;
  SetAlertCubit(this._setAlert) : super(SetAlertInitial());

  Future setAlert(CreateAlertParams params) async {
    emit(SetAlertLoading());
    final response = await _setAlert(params);
    response.fold(
        (l) => emit(
            SetAlertFailure(errorType: l.errorType, errorMessage: l.error)),
        (r) => emit(SetAlertSuccess(r)));
  }
}
