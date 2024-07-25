part of 'buy_sell_transaction_cubit.dart';

abstract class BuySellTransactionState extends Equatable {
  const BuySellTransactionState();
}

class BuySellTransactionInitial extends BuySellTransactionState {
  @override
  List<Object> get props => [];
}

class BuySellTransactionLoading extends BuySellTransactionState {
  @override
  List<Object> get props => [];
}

class BuySellTransactionSuccess extends BuySellTransactionState {
  final BuySellTransationModel buySellTransactionModel;

  const BuySellTransactionSuccess({required this.buySellTransactionModel});

  @override
  List<Object> get props => [buySellTransactionModel];
}

class BuySellTransactionFailure extends BuySellTransactionState {
  final String? errorMessage;
  final AppErrorType errorType;

  const BuySellTransactionFailure(
      {required this.errorType, required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
