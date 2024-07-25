import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/kyc/verify_pan_response_model.dart';
import '../../../../di/get_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/usecases/kyc/verify_pan.dart';
import '../../util_cubits/loading_cubit.dart';

part 'verify_pan_state.dart';

@injectable
class VerifyPanCubit extends Cubit<VerifyPanState> {
  final VerifyPan _verifyPan;

  VerifyPanCubit(this._verifyPan) : super(VerifyPanInitial());

  void verifyPan({required String panNumber}) async {
    getIt<LoadingCubit>().show();
    emit(VerifyPanLoading());
    final response = await _verifyPan(VerifyPanParams(panNumber: panNumber));
    emit(
      response.fold(
        (l) => VerifyPanFailure(errorType: l.errorType, errorMessage: l.error),
        (r) => VerifyPanSuccess(verifyPanResponseModel: r),
      ),
    );

    getIt<LoadingCubit>().hide();
  }

  void fieldChanged() {
    // if (state is VerifyPanInitial) {
    //   return;
    // }
    // emit(VerifyPanInitial());
  }
}
