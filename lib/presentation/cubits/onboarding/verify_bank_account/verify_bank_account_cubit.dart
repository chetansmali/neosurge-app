import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/kyc/verify_bank_account.dart';

part 'verify_bank_account_state.dart';

@injectable
class VerifyBankAccountCubit extends Cubit<VerifyBankAccountState> {
  final VerifyBankAccount _verifyBankAccount;

  VerifyBankAccountCubit(this._verifyBankAccount)
      : super(VerifyBankAccountInitial());

  void verifyBankAccount() async {
    emit(VerifyBankAccountLoading());

    final response = await _verifyBankAccount(NoParams());
    emit(response.fold(
        (l) => VerifyBankAccountFailed(
            appErrorType: l.errorType, errorMessage: l.error),
        (r) => VerifyBankAccountSuccess()));
  }
}
