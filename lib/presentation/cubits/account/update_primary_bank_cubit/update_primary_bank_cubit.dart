import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/account/update_primary_bank_params.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/account/update_primary_bank_account.dart';
import '../../../../domain/usecases/kyc/update_investor_account.dart';
import '../../util_cubits/loading_cubit.dart';

part 'update_primary_bank_state.dart';

@injectable
class UpdatePrimaryBankCubit extends Cubit<UpdatePrimaryBankState> {
  final UpdatePrimaryBankAccount _updatePrimaryBankAccount;
  final UpdateInvestorAccount _updateInvestorAccount;
  final LoadingCubit _loadingCubit;

  UpdatePrimaryBankCubit(this._updatePrimaryBankAccount, this._updateInvestorAccount, this._loadingCubit) : super(UpdatePrimaryBankInitial());

  void updatePrimaryBankAccount({required int index, required int bankAccountId}) async {
    emit(UpdatePrimaryBankLoading());
    _loadingCubit.show();
    final response = await _updatePrimaryBankAccount(UpdatePrimaryBankParams(bankId: bankAccountId));
    response.fold((l) {
      emit(
        UpdatePrimaryBankError(errorType: l.errorType, errorMessage: l.error),
      );
      _loadingCubit.hide();
    }, (r) async {
      final res = await _updateInvestorAccount(NoParams());
      res.fold((l) => emit(UpdatePrimaryBankError(errorType: l.errorType, errorMessage: l.error)), (r) => emit(UpdatePrimaryBankSuccess(index)));
      _loadingCubit.hide();
    });
  }
}
