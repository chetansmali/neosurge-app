import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/mutual_funds/mf_transaction.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/mutual_funds/get_mf_transaction_params.dart';
import '../../../../domain/usecases/mutual_funds/get_mf_transactions.dart';

part 'mf_transactions_state.dart';

@injectable
class MfTransactionsCubit extends Cubit<MfTransactionsState> {
  final GetMfTransactions _getMfTransactions;

  MfTransactionsCubit(this._getMfTransactions) : super(MfTransactionsInitial());

  void fetchMfTransactions({required String isin, required String folioNumber}) async {
    emit(MfTransactionsLoading());
    final res = await _getMfTransactions(GetMfTransactionParams(isin: isin, folio: folioNumber));
    if (isClosed) return;
    emit(res.fold(
      (l) => MfTransactionsError(l.errorType, l.error),
      (r) => MfTransactionsLoaded(r),
    ));
  }
}
