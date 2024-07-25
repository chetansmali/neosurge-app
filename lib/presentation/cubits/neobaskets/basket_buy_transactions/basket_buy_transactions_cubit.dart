import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/neobaskets/basket_buy_transaction.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/neobaskets/basket_buy_transaction_params.dart';
import '../../../../domain/usecases/neobaskets/get_basket_buy_transactions.dart';

part 'basket_buy_transactions_state.dart';

@injectable
class BasketBuyTransactionsCubit extends Cubit<BasketBuyTransactionState> {
  final GetBasketBuyTransactions _getBasketBuyTransactions;

  BasketBuyTransactionsCubit(
    this._getBasketBuyTransactions,
  ) : super(const BasketBuyTransactionInitial());

  void getBasketBuyTransactions(BasketBuyTransactionParams param) async {
    if (state is BasketBuyTransactionLoading) return;

    emit(const BasketBuyTransactionLoading());
    final response = await _getBasketBuyTransactions(param);
    emit(
      response.fold(
        (l) => BasketBuyTransactionFailure(
          errorType: l.errorType,
          error: l.error,
        ),
        (r) => BasketBuyTransactionSuccess(r),
      ),
    );
  }
}
