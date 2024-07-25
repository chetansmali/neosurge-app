import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/lamf/loan_closure_details.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/lamf/loan_closure.dart';

part 'lamf_loan_closure_state.dart';

@Injectable()
class LamfLoanClosureCubit extends Cubit<LamfLoanClosureState> {
  final LoanClosure _loanClosure;
  LamfLoanClosureCubit(this._loanClosure) : super(LamfLoanClosureInitial());
  void lamfLoanClosure() async {
    emit(LamfLoanClosureLoading());
    final response = await _loanClosure(NoParams());
    emit(response.fold((l) => LamfLoanClosureFailure(l.error, l.errorType),
        (r) => LamfLoanClosureSuccess(r)));
  }
}
