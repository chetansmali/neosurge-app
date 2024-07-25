import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/retirement_calculator/generate_retirement_OTP_model.dart';
import '../../../domain/entities/app_error.dart';
import '../../../domain/entities/params/retirement_calculator/generate_retirement_OTP_params.dart';
import '../../../domain/usecases/retirement_calculator/get_retirement_OTP.dart';

part 'generate_retirement_otp_state.dart';

@injectable
class GenerateRetirementOtpCubit extends Cubit<GenerateRetirementOtpState> {
  final GetReterementOTP getReterementOTP;

  GenerateRetirementOtpCubit(this.getReterementOTP)
      : super(GenerateRetirementOtpInitial());

  Future getRetirementotp(GenerateRetirementOTPParams params) async {
    if (state is GenerateRetirementOtpLoading) return;

    emit(GenerateRetirementOtpLoading());
    final response = await getReterementOTP(params);
    response.fold(
      (l) => emit(
        GenerateRetirementOtpFailure(
          errorType: l.errorType,
          errorMessage: l.error,
        ),
      ),
      (r) => emit(
        GenerateRetirementOtpSuccess(r),
      ),
    );
  }
}
