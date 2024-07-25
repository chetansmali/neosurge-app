import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/user/user_bank_details_model.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/account/get_user_bank_list.dart';

part 'user_bank_details_state.dart';

@injectable
class UserBankDetailsCubit extends Cubit<UserBankDetailsState> {
  final GetUserBankList _getUserBankList;

  UserBankDetailsCubit(this._getUserBankList) : super(UserBankDetailsInitial());

  int? _selectedBankIndex;

  UserBank get selectedBank => (state as UserBankDetailsLoaded).bankList[_selectedBankIndex!];

  void fetchBanks() async {
    emit(UserBankDetailsLoading());
    final response = await _getUserBankList(NoParams());
    emit(response.fold((l) => UserBankDetailsLoadError(errorType: l.errorType, errorMessage: l.error), (r) => UserBankDetailsLoaded(r)));
  }

  void storeSingleBank(UserBank bank) {
    emit(UserBankDetailsLoaded([bank]));
    selectBank(0);
  }

  void updatePrimaryBankAccount(int index) {
    List<UserBank> bankList = List.from((state as UserBankDetailsLoaded).bankList);
    //set all banks as non primary
    for (int i = 0; i < bankList.length; i++) {
      bankList[i] = bankList[i].copyWith(isPrimaryAccount: false);
    }
    bankList[index] = bankList[index].copyWith(isPrimaryAccount: true);
    emit(UserBankDetailsLoaded(bankList));
  }

  void addBank(UserBank bankDetails) {
    List<UserBank> bankList = List.from((state as UserBankDetailsLoaded).bankList);
    bankList.add(bankDetails);
    emit(UserBankDetailsLoaded(bankList));
  }

  void updateBank(UserBank bank) {
    List<UserBank> bankList = List.from((state as UserBankDetailsLoaded).bankList);
    bankList[_selectedBankIndex!] = bank;
    emit(UserBankDetailsLoaded(bankList));
  }

  void selectBank(int index) {
    _selectedBankIndex = index;
  }
}
