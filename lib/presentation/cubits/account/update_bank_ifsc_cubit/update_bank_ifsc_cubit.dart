import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/user/user_bank_details_model.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/kyc/upload_bank_details_params.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/account/update_profile_bank_ifsc.dart';
import '../../../../domain/usecases/kyc/update_investor_account.dart';
import '../../util_cubits/loading_cubit.dart';

part 'update_bank_ifsc_state.dart';

@injectable
class UpdateBankIfscCubit extends Cubit<UpdateBankIfscState> {
  final LoadingCubit _loadingCubit;
  final UpdateInvestorAccount _updateInvestorAccount;
  final UpdateProfileBankIfsc _updateProfileBankIfsc;

  UpdateBankIfscCubit(
    this._loadingCubit,
    this._updateInvestorAccount,
    this._updateProfileBankIfsc,
  ) : super(UpdateBankIfscInitial());

  void updateBankIfsc(UserBank bank) async {
    _loadingCubit.show();
    emit(UpdateBankIfscLoading());
    final response = await _updateProfileBankIfsc(UploadBankDetailsParams(
        id: bank.id,
        accountHolderName: bank.accountHolderName,
        accountNumber: bank.accountNumber,
        bankName: bank.bankName,
        branchName: bank.branchName,
        ifscCode: bank.ifscCode,
        accountType: bank.accountType.id,
        isPrimaryAccount: bank.isPrimaryAccount));
    response.fold((l) {
      emit(UpdateBankIfscFailure(errorType: l.errorType, error: l.error));
      _loadingCubit.hide();
    }, (r) async {
      final res = await _updateInvestorAccount(NoParams());
      res.fold((l1) => emit(UpdateBankIfscFailure(errorType: l1.errorType, error: l1.error)), (r1) => emit(UpdateBankIfscSuccess(bank: r)));
      _loadingCubit.hide();
    });
  }
}
