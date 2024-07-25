import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../domain/entities/app_error.dart';
import '../../../../../domain/entities/params/mpin/set_mpin_params.dart';
import '../../../../../domain/usecases/mpin/set_mpin.dart';

part 'set_mpin_state.dart';

@injectable
class SetMPinCubit extends Cubit<SetMPinState> {
  final SetMPin _setMPin;

  SetMPinCubit(this._setMPin) : super(SetMPinInitial());

  void setMPin({required String mPin, required String email}) async {
    emit(SetMPinLoading());
    await Future.delayed(const Duration(seconds: 6));
    final response = await _setMPin(
      SetMPinParams(emailAddress: email, mPin: mPin),
    );
    emit(
      response.fold(
        (l) => SetMPinFailure(appErrorType: l.errorType, errorMessage: l.error),
        (r) => SetMPinSuccess(),
      ),
    );
  }
}
