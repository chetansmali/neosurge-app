import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/lamf/import_loans_details.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/lamf/get_import_loans.dart';

part 'lamf_import_loans_state.dart';

@Injectable()
class LamfImportLoansCubit extends Cubit<LamfImportLoansState> {
  LamfImportLoansCubit(this._getImportLoans) : super(LamfImportLoansInitial());
  final GetImportLoans _getImportLoans;

  void lamfGetImportLoans() async {
    emit(LamfImportLoansLoading());
    final response = await _getImportLoans(NoParams());
    emit(
      response.fold(
        (l) => LamfImportLoansFailure(l.error, l.errorType),
        (r) => LamfImportLoansSuccess(r),
      ),
    );
  }
}
