import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/retirement_calculator/submit_retirement_OTP_model.dart';
import '../../../domain/entities/app_error.dart';
import '../../../domain/entities/params/retirement_calculator/submit_retirement_OTP_params.dart';
import '../../../domain/usecases/retirement_calculator/submit_retirement_OTP.dart';

part 'submit_retirement_otp_state.dart';

@injectable
class SubmitRetirementOtpCubit extends Cubit<SubmitRetirementOtpState> {
  final SubmitRetirementOTP submitRetirementOTP;
  SubmitRetirementOtpCubit(this.submitRetirementOTP)
      : super(SubmitRetirementOtpInitial());

  Future verifyRetirementOtp(SubmitRetirementOTPParams params) async {
    emit(SubmitRetirementOtpLoading());
    final response = await submitRetirementOTP(params);
    response.fold(
        (l) => emit(
              SubmitRetirementOtpFailure(
                  errorType: l.errorType, errorMessage: l.error),
            ),
        (r) => emit(SubmitRetirementOtpSuccess(r)));
  }
}
