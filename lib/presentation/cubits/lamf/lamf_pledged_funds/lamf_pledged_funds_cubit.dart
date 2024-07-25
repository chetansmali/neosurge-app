import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/lamf/get_loan_data_details.dart';
import '../../../../data/models/lamf/get_pledged_funds_details.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/lamf/get_pledged_funds.dart';

part 'lamf_pledged_funds_state.dart';

@Injectable()
class LamfPledgedFundsCubit extends Cubit<LamfPledgedFundsState> {
  final GetPledgedFunds _getPledgedFunds;
  LamfPledgedFundsCubit(this._getPledgedFunds)
      : super(LamfPledgedFundsInitial());

  void lamfGetPledgedFunds() async {
    emit(LamfPledgedFundsLoading());
    final response = await _getPledgedFunds(NoParams());
    emit(response.fold((l) => LamfPledgedFundsFailure(l.error, l.errorType),
        (r) => LamfPledgedFundsSuccess(r)));
  }
}
