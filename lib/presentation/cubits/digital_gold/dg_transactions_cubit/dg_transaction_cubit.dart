import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/digital_gold/dg_transaction_response_model.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/enums.dart';
import '../../../../domain/entities/params/digital_gold/get_dg_transaction_params.dart';
import '../../../../domain/usecases/digital_gold/get_dg_transactions.dart';

part 'dg_transaction_state.dart';

@injectable
class DgTransactionCubit extends Cubit<DgTransactionState> {
  final GetDgTransactions _getDgTransactions;

  DgTransactionCubit(this._getDgTransactions) : super(DgTransactionInitial());

  int _from = 0; //Used for pagination
  final int _pageSize = 20; //20 transactions are being fetched every time

  void fetchTransactions({int? pageSize, required DgTransactionStatus transactionStatus, bool isFirstFetch = false}) async {
    if (state is DgTransactionLoading) return;
    List<DgTransactionResponseModel> oldTransactions = [];
    if (isFirstFetch) {
      _from = 0;
    } else {
      if (state is DgTransactionLoaded) {
        oldTransactions = (state as DgTransactionLoaded).transactionList;
      } else if (state is DgTransactionLoadError) {
        oldTransactions = (state as DgTransactionLoadError).oldTransactionList;
      }
    }
    emit(DgTransactionLoading(
      oldTransactions,
      isFirstFetch: _from == 0,
    ));
    final response = await _getDgTransactions(GetDGTransactionParams(
      status: transactionStatus,
      type: DGTransactionType.buySell,
      limit: pageSize ?? _pageSize,
      from: _from,
    ));
    response.fold(
        (l) => emit(DgTransactionLoadError(
              isFirstFetch: _from == 0,
              oldTransactionList: oldTransactions,
              appErrorType: l.errorType,
            )), (r) {
      List<DgTransactionResponseModel> newTransactions = r;
      if (newTransactions.isEmpty) {
        emit(DgTransactionLoaded(
          transactionList: oldTransactions,
          isLastPage: true,
        ));
      } else {
        _from += _pageSize;
        emit(DgTransactionLoaded(
          transactionList: oldTransactions + newTransactions,
          isLastPage: false,
        ));
      }
    });
  }

  void fetchProcessingTransactions() async {
    emit(const DgTransactionLoading([]));
    final response = await _getDgTransactions(GetDGTransactionParams(
      status: DgTransactionStatus.processing,
      type: DGTransactionType.buySell,
      limit: 1000,
      from: 0,
    ));
    emit(response.fold((l) => DgTransactionLoadError(appErrorType: l.errorType, errorMessage: l.error), (r) => DgTransactionLoaded(transactionList: r)));
  }
}
