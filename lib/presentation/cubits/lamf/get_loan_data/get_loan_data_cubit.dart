import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/lamf/get_loan_data_response.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/lamf/get_loan_data_params.dart';
import '../../../../domain/usecases/lamf/get_import_loan_data.dart';

part 'get_loan_data_state.dart';

@injectable
class GetLoanDataCubit extends Cubit<GetLoanDataState> {
  GetLoanDataCubit(this._getLoanData) : super(GetLoanDataInitial());

  final GetImportLoanData _getLoanData;

  Future getLoanData(GetLoanDataParams params) async {
    emit(GetLoanDataLoading());
    final response = await _getLoanData(params);
    emit(response.fold(
        (l) => GetLoanDataFailure(
            appErrorType: l.errorType, errorMessage: l.error),
        (r) => GetLoanDataSuccess(getLoanDataResponse: r)));
  }
}
