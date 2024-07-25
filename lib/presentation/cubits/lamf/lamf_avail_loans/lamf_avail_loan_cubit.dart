import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/lamf/avail_loan_details.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/lamf/get_avail_loan.dart';

part 'lamf_avail_loan_state.dart';

@Injectable()
class LamfAvailLoanCubit extends Cubit<LamfAvailLoanState> {
  final GetAvailLoan _getAvailLoan;
  LamfAvailLoanCubit(this._getAvailLoan) : super(LamfAvailLoanInitial());

  void availLoans() async {
    emit(LamfAvailLoanLoading());
    final response = await _getAvailLoan(NoParams());
    emit(response.fold((l) => LamfAvailLoanFailure(l.error, l.errorType),
        (r) => LamfAvailLoanSuccess(r)));
  }
}
