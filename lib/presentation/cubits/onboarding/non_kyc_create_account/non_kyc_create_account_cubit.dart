import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/kyc/create_kyc_request_params.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/digital_gold/create_gold_kyc.dart';
import '../../../../domain/usecases/digital_gold/create_gold_user.dart';
import '../../../../domain/usecases/digital_gold/dg_accept_terms.dart';
import '../../../../domain/usecases/digital_gold/dg_add_bank_account.dart';
import '../../../../domain/usecases/kyc/create_kyc_request.dart';

part 'non_kyc_create_account_state.dart';

@injectable
class NonKycCreateAccountCubit extends Cubit<NonKycCreateAccountState> {
  final CreateKycRequest _createKycRequest;
  final CreateGoldUser _createGoldUser;
  final DGAcceptTerms _dgAcceptTerms;
  final AddDgBankAccount _addDgBankAccount;
  final CreateGoldKyc _createGoldKyc;

  NonKycCreateAccountCubit(
    this._createKycRequest,
    this._createGoldUser,
    this._dgAcceptTerms,
    this._addDgBankAccount,
    this._createGoldKyc,
  ) : super(NonKycCreateAccountInitial());

  void createAccount({
    required double latitude,
    required double longitude,
  }) async {
    emit(const NonKycCreateAccountLoading());
    bool shouldRetry = true;
    do {
      final res = await _createKycRequest(CreateKycRequestParams(isFinalSubmit: true, latitude: latitude, longitude: longitude));
      res.fold((l) async {
        if (l.statusCode != 102) {
          shouldRetry = false;
          emit(NonKycCreateAccountFailure(errorMessage: l.error, appErrorType: l.errorType));
          return;
        } else {
          await Future.delayed(const Duration(seconds: 5));
        }
      }, (r) {
        shouldRetry = false;
        emit(NonKycCreateAccountPartSuccess());
      });
    } while (shouldRetry);
  }

  void createAccountSuccessFunc(bool retakeKyc) async {
    // If the user is retaking kyc then we need not call createGoldUser
    if (retakeKyc) {
      await _addDgBankAccount(NoParams());
      emit(NonKycCreateAccountSuccess());
      return;
    }
    await _createGoldUserFunc();
    emit(NonKycCreateAccountSuccess());
  }

  Future<void> _createGoldUserFunc() async {
    await _createGoldUser(NoParams());
    await _dgAcceptTerms(NoParams());
    await Future.wait([
      _addDgBankAccount(NoParams()),
      _createGoldKyc(
        NoParams(),
      )
    ]);
    return;
  }
}
