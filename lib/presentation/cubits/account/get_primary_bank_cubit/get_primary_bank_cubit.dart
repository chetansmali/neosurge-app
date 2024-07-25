import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/user/user_bank_details_model.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/account/get_user_primary_bank.dart';

part 'get_primary_bank_state.dart';

@injectable
class GetPrimaryBankCubit extends Cubit<GetPrimaryBankState> {
  final GetUserPrimaryBank _getUserPrimaryBank;

  GetPrimaryBankCubit(this._getUserPrimaryBank) : super(GetPrimaryBankInitial());

  void getPrimaryBank() async {
    emit(GetPrimaryBankLoading());
    final res = await _getUserPrimaryBank(NoParams());
    emit(res.fold((l) => GetPrimaryBankLoadError(l.errorType, l.error), (r) => GetPrimaryBankLoaded(r)));
  }
}
