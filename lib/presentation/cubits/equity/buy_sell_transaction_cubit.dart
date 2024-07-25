import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/equity/buy_sell_transaction.dart';
import '../../../domain/entities/app_error.dart';
import '../../../domain/entities/params/equity/buy_sell_transaction.dart';
import '../../../domain/usecases/equity/get_buy_sell_transation.dart';

part 'buy_sell_transaction_state.dart';

@injectable
class BuySellTransactionCubit extends Cubit<BuySellTransactionState> {
  final GetBuySellTrasaction getBuySellTrasaction;

  BuySellTransactionCubit(this.getBuySellTrasaction)
      : super(BuySellTransactionInitial());

  Future fetchBuySell(BuySellTransactionParams params) async {
    if (state is BuySellTransactionLoading) return;

    emit(BuySellTransactionLoading());

    final response = await getBuySellTrasaction(params);

    response.fold(
      (l) => emit(BuySellTransactionFailure(
          errorType: l.errorType, errorMessage: l.error)),
      (r) => emit(
        BuySellTransactionSuccess(buySellTransactionModel: r),
      ),
    );
  }
}
