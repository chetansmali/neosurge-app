import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../data/models/user/user.dart';
import '../../../../../domain/entities/app_error.dart';
import '../../../../../domain/usecases/mpin/login_with_mpin.dart';
import '../../util_cubits/loading_cubit.dart';

part 'mpin_login_state.dart';

@injectable
class MPinLoginCubit extends Cubit<MPinLoginState> {
  final LoginWithMPin _loginWithMPin;
  final LoadingCubit _loadingCubit;

  MPinLoginCubit(this._loginWithMPin, this._loadingCubit) : super(MPinLoginInitial());

  void loginWithMPin({
    required String mPin,
    required String phoneNumber,
  }) async {
    _loadingCubit.show();
    emit(MPinLoginLoading());

    final response = await _loginWithMPin(LoginWithMPinParams(mPin: mPin, mobileNumber: phoneNumber));
    emit(response.fold((l) => MPinLoginFailure(errorType: l.errorType, errorMessage: l.error), (r) => MPinLoginSuccess(user: r)));
    _loadingCubit.hide();
  }

  void reset() {
    emit(MPinLoginInitial());
  }
}
