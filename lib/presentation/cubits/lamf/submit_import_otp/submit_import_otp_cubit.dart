import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/lamf/get_import_landing_page_model.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/lamf/submit_import_otp_params.dart';
import '../../../../domain/usecases/lamf/submit_import_otp.dart';

part 'submit_import_otp_state.dart';

@injectable
class SubmitImportOtpCubit extends Cubit<SubmitImportOtpState> {
  SubmitImportOtpCubit(this._submitImportOtp) : super(SubmitImportOtpInitial());

  final SubmitImportOtp _submitImportOtp;

  Future submitImportOtp(SubmitImportOtpParams params) async {
    emit(SubmitImportOtpLoading());
    final response = await _submitImportOtp(params);
    emit(response.fold(
        (l) => SubmitImportOtpFailure(
            appErrorType: l.errorType, errorMessage: l.error),
        (r) => SubmitImportOtpSuccess(getImportLandingPageResponse: r)));
  }
}
