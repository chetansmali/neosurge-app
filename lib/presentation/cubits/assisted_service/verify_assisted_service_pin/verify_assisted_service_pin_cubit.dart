import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/assisted_service/verify_assisted_service_pin_response.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/assisted_service/verify_assisted_service_pin_params.dart';
import '../../../../domain/usecases/assisted_service/verify_assisted_service_pin.dart';
import '../../util_cubits/loading_cubit.dart';

part 'verify_assisted_service_pin_state.dart';

@injectable
class VerifyAssistedServicePinCubit
    extends Cubit<VerifyAssistedServicePinState> {
  final VerifyAssistedServicePin _verifyAssistedServicePin;
  final LoadingCubit _loadingCubit;

  VerifyAssistedServicePinCubit(
      this._verifyAssistedServicePin, this._loadingCubit)
      : super(VerifyAssistedServicePinInitial());

  void verifyAssistedServicePin(
      {required int userId, required String pin}) async {
    _loadingCubit.show();
    emit(VerifyAssistedServicePinLoading());
    final response = await _verifyAssistedServicePin
        .call(VerifyAssistedServicePinParams(pin: pin, userId: userId));
    emit(response.fold(
        (l) => VerifyAssistedServicePinFailure(
            errorType: l.errorType, errorMessage: l.error),
        (r) => VerifyAssistedServicePinSuccess(response: r)));

    _loadingCubit.hide();
  }
}
