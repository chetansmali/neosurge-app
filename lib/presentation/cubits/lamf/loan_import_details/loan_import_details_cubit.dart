import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/lamf/loan_import_details_response.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/lamf/get_loan_import_details.dart';

part 'loan_import_details_state.dart';

@injectable
class LoanImportDetailsCubit extends Cubit<LoanImportDetailsState> {
  LoanImportDetailsCubit(this._getLoanImportDetails)
      : super(LoanImportDetailsInitial());

  final GetLoanImportDetails _getLoanImportDetails;

  Future getLoanImportDetails() async {
    emit(LoanImportDetailsLoading());
    final response = await _getLoanImportDetails(NoParams());
    emit(response.fold(
        (l) => LoanImportDetailsFailure(
            appErrorType: l.errorType, errorMessage: l.error),
        (r) => LoanImportDetailsSuccess(loanImportDetailsResponse: r)));
  }
}
