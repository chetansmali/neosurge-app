import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/lamf/get_loan_data_details.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/lamf/get_loan_data.dart';

part 'lamf_get_loan_data_state.dart';

@Injectable()
class LamfGetLoanDataCubit extends Cubit<LamfGetLoanDataState> {
  final GetLoanData _getLoanData;
  LamfGetLoanDataCubit(this._getLoanData) : super(LamfGetLoanDataInitial());

  void lamfGetLoanData() async {
    emit(LamfGetLoanDataLoading());
    final response = await _getLoanData(NoParams());
    emit(response.fold((l) => LamfGetLoanDataFailure(l.error, l.errorType),
        (r) => LamfGetLoanDataSuccess(r)));
  }
}
