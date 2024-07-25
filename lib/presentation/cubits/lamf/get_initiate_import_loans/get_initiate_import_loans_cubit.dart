import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/lamf/get_init_loan_import_response.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/lamf/initiate_loan_import_params.dart';
import '../../../../domain/usecases/lamf/get_initiate_import_loans.dart';

part 'get_initiate_import_loans_state.dart';

@injectable
class GetInitiateImportLoansCubit extends Cubit<GetInitiateImportLoansState> {
  GetInitiateImportLoansCubit(this._getInitiateImporLoans)
      : super(GetInitiateImportLoansInitial());

  final GetInititateImportLoans _getInitiateImporLoans;

  void getInitiateImporLoans(GetInitiateLoanImportsParams params) async {
    emit(GetInitiateImportLoansLoading());

    final response = await _getInitiateImporLoans(params);
    emit(
      response.fold(
        (l) => GetInitiateImportLoansFailure(l.error, l.errorType),
        (r) => GetInitiateImportLoansSuccess(getInitiateLoanImportResponse: r),
      ),
    );
  }
}
