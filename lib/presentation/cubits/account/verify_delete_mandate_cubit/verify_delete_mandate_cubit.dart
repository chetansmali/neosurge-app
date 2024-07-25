import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/account/verify_delete_mandate_params.dart';
import '../../../../domain/usecases/account/verify_delete_mandate.dart';

part 'verify_delete_mandate_state.dart';

@injectable
class VerifyDeleteMandateCubit extends Cubit<VerifyDeleteMandateState> {
  final VarifyDeleteMandate _varifyDeleteMandate;

  VerifyDeleteMandateCubit(
    this._varifyDeleteMandate,
  ) : super(VerifyDeleteMandateInitial());

  void verifyDeleteMandate({
    required String deleteId,
    required String otp,
  }) async {
    if (state is VerifyDeleteMandateLoading) return;

    emit(VerifyDeleteMandateLoading());
    final result = await _varifyDeleteMandate(
      VerifyDeleteMandateParams(verifyDeleteMandateRedId: deleteId, otp: otp),
    );
    result.fold(
      (l) => emit(
        VerifyDeleteMandateError(
          errorMessage: l.error,
          errorType: l.errorType,
        ),
      ),
      (r) => emit(
        const VerifyDeleteMandateSuccess(),
      ),
    );
  }
}
