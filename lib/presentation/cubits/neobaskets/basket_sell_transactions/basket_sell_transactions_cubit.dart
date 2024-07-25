import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/neobaskets/basket_sell_transaction.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/neobaskets/basket_sell_transaction_params.dart';
import '../../../../domain/usecases/neobaskets/get_basket_sell_transactions.dart';

part 'basket_sell_transactions_state.dart';

@injectable
class BasketSellTransactionsCubit extends Cubit<BasketSellTransactionState> {
  final GetBasketSellTransactions _getBasketSellTransactions;

  BasketSellTransactionsCubit(
    this._getBasketSellTransactions,
  ) : super(const BasketSellTransactionInitial());

  void getBasketSellTransactions(BasketSellTransactionParams param) async {
    if (state is BasketSellTransactionLoading) return;

    emit(const BasketSellTransactionLoading());

    final response = await _getBasketSellTransactions(param);

    emit(
      response.fold(
        (l) => BasketSellTransactionFailure(
          errorType: l.errorType,
          error: l.error,
        ),
        (r) => BasketSellTransactionSuccess(r),
      ),
    );
  }
}
