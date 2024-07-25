import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/lamf/initiate_withdrawal_details.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/lamf/initiate_withdrawal.dart';

part 'lamf_initiate_withdrawal_state.dart';

@injectable
class LamfInitiateWithdrawalCubit extends Cubit<LamfInitiateWithdrawalState> {
  LamfInitiateWithdrawalCubit(this._initiateWithdrawal)
      : super(LamfInitiateWithdrawalInitial());

  final InitiateWithdrawal _initiateWithdrawal;

  void initiateWithdrawal() async {
    emit(LamfInitiateWithdrawalLoading());
    final response = await _initiateWithdrawal(NoParams());
    emit(response.fold(
      (l) => LamfInitiateWithdrawalFailure(l.error, l.errorType),
      (r) => LamfInitiateWithdrawalSuccess(initiateWithdrawalDetails: r),
    ));
  }
}
