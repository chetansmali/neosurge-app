import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/app_error.dart';
import '../../../../domain/usecases/onboarding/generate_mobile_otp.dart';
import '../../../../domain/usecases/onboarding/login_with_email.dart';
import '../../util_cubits/loading_cubit.dart';

part 'resend_otp_state.dart';

@injectable
class ResendOtpCubit extends Cubit<ResendOtpState> {
  final LoginWithEmail _loginWithEmail;
  final GenerateMobileOtp _generateMobileOtp;
  final LoadingCubit _loadingCubit;

  ResendOtpCubit(this._loginWithEmail, this._generateMobileOtp, this._loadingCubit) : super(ResendOtpInitial());

  void resendMobileOtp({required String mobileNumber}) async {
    _loadingCubit.show();
    emit(ResendOtpLoading());
    final response = await _generateMobileOtp(GenerateMobileOTPParams(mobileNumber: mobileNumber));
    emit(response.fold((l) => ResendOtpFailure(l.error, l.errorType), (r) => ResendOtpSuccess()));
    _loadingCubit.hide();
  }

  void resendEmailOtp({required String email}) async {
    _loadingCubit.show();
    emit(ResendOtpLoading());
    final response = await _loginWithEmail(LoginWithEmailParams(emailId: email));
    emit(response.fold((l) => ResendOtpFailure(l.error, l.errorType), (r) => ResendOtpSuccess()));
    _loadingCubit.hide();
  }
}
