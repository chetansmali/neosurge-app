part of 'basket_sell_transactions_cubit.dart';

abstract class BasketSellTransactionState extends Equatable {
  const BasketSellTransactionState();
}

class BasketSellTransactionInitial extends BasketSellTransactionState {
  const BasketSellTransactionInitial();

  @override
  List<Object> get props => [];
}

class BasketSellTransactionLoading extends BasketSellTransactionState {
  const BasketSellTransactionLoading();

  @override
  List<Object> get props => [];
}

class BasketSellTransactionSuccess extends BasketSellTransactionState {
  final List<BasketSellTransaction> transactions;

  const BasketSellTransactionSuccess(this.transactions);

  @override
  List<Object> get props => [transactions];
}

class BasketSellTransactionFailure extends BasketSellTransactionState {
  final AppErrorType errorType;
  final String? error;

  const BasketSellTransactionFailure({
    required this.error,
    required this.errorType,
  });

  @override
  List<Object> get props => [];
}
