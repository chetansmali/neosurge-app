import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/lamf/get_loan_user_details.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/lamf/get_credit_limit.dart';

part 'lamf_get_credit_limit_state.dart';

@injectable
class LamfGetCreditLimitCubit extends Cubit<LamfGetCreditLimitState> {
  final GetCreditLimit _getCreditLimit;
  LamfGetCreditLimitCubit(this._getCreditLimit)
      : super(LamfGetCreditLimitInitial());

  void lamfGetCreditLimit() async {
    emit(LamfGetCreditLimitLoading());
    final response = await _getCreditLimit(NoParams());
    emit(response.fold((l) => LamfGetCreditLimitFailure(l.error, l.errorType),
        (r) => LamfGetCreditLimitSuccess(r)));
  }
}
