import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/enums.dart';
import '../../../../domain/entities/params/kyc/create_kyc_account_params.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/digital_gold/create_gold_kyc.dart';
import '../../../../domain/usecases/digital_gold/create_gold_user.dart';
import '../../../../domain/usecases/digital_gold/dg_accept_terms.dart';
import '../../../../domain/usecases/digital_gold/dg_add_bank_account.dart';
import '../../../../domain/usecases/kyc/create_investor_account.dart';
import '../../../../domain/usecases/kyc/create_mf_account.dart';

part 'kyc_create_account_state.dart';

@injectable
class KycCreateAccountCubit extends Cubit<KycCreateAccountState> {
  final CreateInvestorAccount _createInvestorAccount;
  final CreateMfAccount _createMfAccount;
  final CreateGoldUser _createGoldUser;
  final DGAcceptTerms _dgAcceptTerms;
  final AddDgBankAccount _addDgBankAccount;
  final CreateGoldKyc _createGoldKyc;

  KycCreateAccountCubit(
    this._createInvestorAccount,
    this._createMfAccount,
    this._createGoldUser,
    this._dgAcceptTerms,
    this._addDgBankAccount,
    this._createGoldKyc,
  ) : super(KycCreateAccountInitial());

  void createInvestorAccountFunc({required int userId, required bool retakeKyc}) async {
    emit(const KycCreateAccountLoading(accountCreationStep: AccountCreationStep.investor));
    final res = await _createInvestorAccount(CreateKycAccountParams(userId: userId));
    res.fold((l) {
      emit(KycCreateAccountFailure(errorMessage: l.error, appErrorType: l.errorType));
      return;
    }, (r) {
      _createMfAccountFunc(userId: userId, retakeKyc: retakeKyc);
    });
  }

  void _createMfAccountFunc({required int userId, required bool retakeKyc}) async {
    emit(const KycCreateAccountLoading(accountCreationStep: AccountCreationStep.mf));
    final res = await _createMfAccount(CreateKycAccountParams(userId: userId));
    res.fold((l) {
      emit(KycCreateAccountFailure(errorMessage: l.error, appErrorType: l.errorType));
      return;
    }, (r) async {
      //If retake kyc is true then we need not create gold user again
      if (retakeKyc) {
        await _addDgBankAccount(NoParams());
        emit(const KycCreateAccountSuccess());
        return;
      }
      await _createGoldUserFunc();
      emit(const KycCreateAccountSuccess());
    });
  }

  Future<void> _createGoldUserFunc() async {
    await _createGoldUser(NoParams());
    await _dgAcceptTerms(NoParams());
    await _addDgBankAccount(NoParams());
    await _createGoldKyc(NoParams());
    return;
  }
}
