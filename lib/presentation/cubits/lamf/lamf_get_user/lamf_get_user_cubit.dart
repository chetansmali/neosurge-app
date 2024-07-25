import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/lamf/get_loan_user_details.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/lamf/get_loan_user.dart';

part 'lamf_get_user_state.dart';

@injectable
class LamfGetUserCubit extends Cubit<LamfGetUserState> {
  final GetLoanUser _getUserLoan;
  LamfGetUserCubit(this._getUserLoan) : super(LamfGetUserInitial());

  void lamfGetUser() async {
    emit(LamfGetUserLoading());
    final response = await _getUserLoan(NoParams());
    emit(response.fold((l) => LamfGetUserFailure(l.error, l.errorType),
        (r) => LamfGetUserSuccess(r)));
  }
}
