part of 'basket_buy_transactions_cubit.dart';

abstract class BasketBuyTransactionState extends Equatable {
  const BasketBuyTransactionState();
}

class BasketBuyTransactionInitial extends BasketBuyTransactionState {
  const BasketBuyTransactionInitial();

  @override
  List<Object> get props => [];
}

class BasketBuyTransactionLoading extends BasketBuyTransactionState {
  const BasketBuyTransactionLoading();

  @override
  List<Object> get props => [];
}

class BasketBuyTransactionSuccess extends BasketBuyTransactionState {
  final List<BasketBuyTransaction> transactions;

  const BasketBuyTransactionSuccess(this.transactions);

  @override
  List<Object> get props => [transactions];
}

class BasketBuyTransactionFailure extends BasketBuyTransactionState {
  final AppErrorType errorType;
  final String? error;

  const BasketBuyTransactionFailure({
    required this.error,
    required this.errorType,
  });

  @override
  List<Object> get props => [];
}
