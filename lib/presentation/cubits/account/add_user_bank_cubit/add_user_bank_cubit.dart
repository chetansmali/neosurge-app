import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/user/user_bank_details_model.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/kyc/upload_bank_details_params.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/account/add_profile_bank_details.dart';
import '../../../../domain/usecases/kyc/update_investor_account.dart';
import '../../util_cubits/loading_cubit.dart';

part 'add_user_bank_state.dart';

@injectable
class AddUserBankCubit extends Cubit<AddUserBankState> {
  final AddProfileBankDetails _addProfileBankDetails;
  final UpdateInvestorAccount _updateInvestorAccount;
  final LoadingCubit _loadingCubit;

  AddUserBankCubit(this._addProfileBankDetails, this._updateInvestorAccount, this._loadingCubit) : super(AddUserBankInitial());

  void addBank(UploadBankDetailsParams uploadBankDetailsParams) async {
    _loadingCubit.show();
    emit(AddUserBankLoading());
    final response = await _addProfileBankDetails(uploadBankDetailsParams);
    response.fold((l) {
      emit(AddUserBankError(errorType: l.errorType, errorMessage: l.error));
      _loadingCubit.hide();
    }, (r) async {
      final res = await _updateInvestorAccount(NoParams());
      res.fold((l1) => emit(AddUserBankError(errorType: l1.errorType, errorMessage: l1.error)), (r1) => emit(AddUserBankSuccess(userBank: r)));
      _loadingCubit.hide();
    });
  }
}
