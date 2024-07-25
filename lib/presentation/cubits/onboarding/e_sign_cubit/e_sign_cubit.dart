import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/kyc/esign_submit.dart';

part 'e_sign_state.dart';

@injectable
class ESignCubit extends Cubit<ESignState> {
  final ESignSubmit _eSignSubmit;

  ESignCubit(this._eSignSubmit) : super(ESignInitial());

  void eSignSubmit() async {
    emit(const ESignLoading());
    final response = await _eSignSubmit(NoParams());
    emit(response.fold((l) => ESignFailure(errorType: l.errorType, errorMessage: l.error), (r) => ESignLoadSuccess(eSignUrl: r.fpESignRedirectUrl)));
  }

  void eSignSubmitSuccess() {
    emit(const ESignSubmitSuccess());
  }

  void eSignSubmitFailure() {
    emit(const ESignFailure(errorType: AppErrorType.api, errorMessage: 'ESign Submission failed due to some error. Please try again!'));
  }
}
