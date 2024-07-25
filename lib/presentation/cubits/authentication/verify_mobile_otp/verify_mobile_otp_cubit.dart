import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/app_error.dart';
import '../../../../domain/usecases/onboarding/verify_mobile_otp.dart';

part 'verify_mobile_otp_state.dart';

@injectable
class VerifyMobileOtpCubit extends Cubit<VerifyMobileOtpState> {
  final VerifyMobileOtp _verifyMobileOtp;

  VerifyMobileOtpCubit(this._verifyMobileOtp) : super(VerifyMobileOtpInitial());

  void verifyMobileOtp({
    required String mobileNumber,
    required String otp,
  }) async {
    emit(VerifyMobileOtpLoading());
    final response =
        await _verifyMobileOtp(VerifyMobileOtpParams(mobileNumber, otp));
    emit(
      response.fold(
        (l) => VerifyMobileOtpFailure(
            errorType: l.errorType, errorMessage: l.error),
        (r) => VerifyMobileOtpSuccess(),
      ),
    );
  }
}
