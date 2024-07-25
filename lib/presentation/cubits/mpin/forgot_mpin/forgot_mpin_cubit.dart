import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/mpin/verify_forgot_mpin_otp_params.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/mpin/forgot_mpin_generate_otp.dart';
import '../../../../domain/usecases/mpin/forgot_mpin_verify_otp.dart';

part 'forgot_mpin_state.dart';

@injectable
class ForgotMPinCubit extends Cubit<ForgotMPinState> {
  final ForgotMPinGenerateOtp _forgotMPinGenerateOtp;
  final ForgotMPinVerifyOtp _forgotMPinVerifyOtp;

  ForgotMPinCubit(this._forgotMPinGenerateOtp, this._forgotMPinVerifyOtp)
      : super(ForgotMPinInitial());

  void generateOtp() async {
    emit(ForgotMPinLoading());
    final response = await _forgotMPinGenerateOtp(NoParams());
    emit(response.fold(
        (l) =>
            ForgotMPinFailure(appErrorType: l.errorType, errorMessage: l.error),
        (r) => const ForgotMPinSuccess()));
  }

  void verifyOtp({required String otp}) async {
    emit(ForgotMPinLoading());
    final response =
        await _forgotMPinVerifyOtp(VerifyForgotMPinOtpParams(otp: otp));
    emit(response.fold(
        (l) => ForgotMPinFailure(
            appErrorType: l.errorType, errorMessage: l.error, isVerify: true),
        (r) => const ForgotMPinSuccess(isVerify: true)));
  }

  void reset() {
    emit(ForgotMPinInitial());
  }
}
