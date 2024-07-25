import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/digital_gold/dg_delivery_transaction_response_model.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/enums.dart';
import '../../../../domain/entities/params/digital_gold/get_dg_transaction_params.dart';
import '../../../../domain/usecases/digital_gold/get_dg_delivery_transactions.dart';

part 'dg_delivery_transaction_state.dart';

@injectable
class DgDeliveryTransactionCubit extends Cubit<DgDeliveryTransactionState> {
  final GetDgDeliveryTransactions _getDgDeliveryTransactions;

  DgDeliveryTransactionCubit(this._getDgDeliveryTransactions) : super(DgDeliveryTransactionInitial());

  int _from = 0; //Used for pagination
  final int _pageSize = 20; //20 transactions are being fetched every time

  void fetchTransactions({required DgTransactionStatus transactionStatus, int? pageSize, bool isFirstFetch = false}) async {
    if (state is DgDeliveryTransactionLoading) return;
    List<DgDeliveryTransactionResponseModel> oldTransactions = [];
    if (isFirstFetch) {
      _from = 0;
    } else {
      if (state is DgDeliveryTransactionLoaded) {
        oldTransactions = (state as DgDeliveryTransactionLoaded).transactionList;
      } else if (state is DgDeliveryTransactionLoadError) {
        oldTransactions = (state as DgDeliveryTransactionLoadError).oldTransactionList;
      }
    }
    emit(DgDeliveryTransactionLoading(
      oldTransactions,
      isFirstFetch: _from == 0,
    ));
    final response = await _getDgDeliveryTransactions(GetDGTransactionParams(
      status: transactionStatus,
      limit: pageSize ?? _pageSize,
      from: _from,
    ));
    response.fold(
        (l) => emit(DgDeliveryTransactionLoadError(
              isFirstFetch: _from == 0,
              oldTransactionList: oldTransactions,
              appErrorType: l.errorType,
            )), (r) {
      List<DgDeliveryTransactionResponseModel> newTransactions = r;
      if (newTransactions.isEmpty) {
        emit(DgDeliveryTransactionLoaded(
          transactionList: oldTransactions,
          isLastPage: true,
        ));
      } else {
        _from += _pageSize;
        emit(DgDeliveryTransactionLoaded(
          transactionList: oldTransactions + newTransactions,
          isLastPage: false,
        ));
      }
    });
  }

  void fetchProcessingTransactions() async {
    emit(const DgDeliveryTransactionLoading([]));
    final response = await _getDgDeliveryTransactions(GetDGTransactionParams(
      status: DgTransactionStatus.processing,
      type: DGTransactionType.delivery,
      limit: 1000,
      from: 0,
    ));
    emit(response.fold((l) => DgDeliveryTransactionLoadError(appErrorType: l.errorType, errorMessage: l.error), (r) => DgDeliveryTransactionLoaded(transactionList: r)));
  }
}
