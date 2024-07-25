import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/lamf/update_loan_status_details.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/lamf/update_loan_params.dart';
import '../../../../domain/usecases/lamf/update_loan_status.dart';

part 'lamf_update_loan_status_state.dart';

@injectable
class LamfUpdateLoanStatusCubit extends Cubit<LamfUpdateLoanStatusState> {
  final UpdateLoanStatus _updateLoanStatus;
  LamfUpdateLoanStatusCubit(this._updateLoanStatus)
      : super(LamfUpdateLoanStatusInitial());

  void updateLoanUserStatus(String applicationState) async {
    emit(LamfUpdateLoanStatusLoading());
    final response = await _updateLoanStatus(
        UpdateLoanParams(applicationState: applicationState));
    emit(response.fold((l) => LamfUpdateLoanStatusFailure(l.error, l.errorType),
        (r) => LamfUpdateLoanStatusSuccess(r)));
  }
}
