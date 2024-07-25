import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/app_error.dart';
import '../../../../domain/usecases/onboarding/generate_mobile_otp.dart';

part 'mobile_otp_state.dart';

@injectable
class MobileOtpCubit extends Cubit<MobileOtpState> {
  final GenerateMobileOtp _generateMobileOtp;

  MobileOtpCubit(this._generateMobileOtp) : super(MobileOtpInitial());

  void generateMobileOtp({required String mobileNumber}) async {
    emit(MobileOtpGenerating());
    final response = await _generateMobileOtp(
      GenerateMobileOTPParams(mobileNumber: mobileNumber),
    );
    log('generateMobileOtp: $response');
    emit(
      response.fold(
        (l) => MobileOtpGenerateFailure(
          errorMessage: l.error,
          errorType: l.errorType,
        ),
        (r) => MobileOtpGenerateSuccess(),
      ),
    );
  }
}
