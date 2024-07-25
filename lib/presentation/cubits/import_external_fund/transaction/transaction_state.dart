part of 'transaction_cubit.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();
}

class TransactionInitial extends TransactionState {
  @override
  List<Object?> get props => [];
}

class TransactionLoading extends TransactionState {
  @override
  List<Object?> get props => [];
}

class TransactionInitialised extends TransactionState {
  final InitialiseTransactionReposnse initialiseTransactionReposnse;

  const TransactionInitialised({required this.initialiseTransactionReposnse})
      : super();

  @override
  List<Object?> get props => [initialiseTransactionReposnse];
}

class TransactionValidated extends TransactionState {
  final ValidateTransactionResponse validateTransactionResponse;

  const TransactionValidated({required this.validateTransactionResponse})
      : super();

  @override
  List<Object?> get props => [validateTransactionResponse];
}

class TransactionError extends TransactionState {
  final String? errorMessage;
  final AppErrorType appErrorType;

  const TransactionError({
    required this.appErrorType,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        appErrorType,
        errorMessage,
      ];
}
