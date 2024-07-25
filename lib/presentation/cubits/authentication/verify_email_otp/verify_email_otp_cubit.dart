import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/user/user.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/authentication/verify_email_otp_params.dart';
import '../../../../domain/usecases/onboarding/verify_email_otp.dart';
import '../../util_cubits/loading_cubit.dart';

part 'verify_email_otp_state.dart';

@injectable
class VerifyEmailOtpCubit extends Cubit<VerifyEmailOtpState> {
  final VerifyEmailOtp _verifyEmailOTP;
  final LoadingCubit _loadingCubit;

  VerifyEmailOtpCubit(this._verifyEmailOTP, this._loadingCubit) : super(VerifyEmailOtpInitial());

  void verifyEmailOtp({required String emailId, required String otp, required String sessionId, required String creationTime, required String fcmToken}) async {
    _loadingCubit.show();
    emit(VerifyEmailOtpLoading());
    final response = await _verifyEmailOTP(VerifyEmailOtpParams(emailAddress: emailId, userOTP: otp, sessionId: sessionId, creationTime: creationTime, fcmToken: fcmToken));
    emit(response.fold((l) => VerifyEmailOtpFailure(errorType: l.errorType, errorMessage: l.error), (r) => VerifyEmailOtpSuccess(user: r)));
    _loadingCubit.hide();
  }
}
