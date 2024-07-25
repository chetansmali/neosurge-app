part of 'transactionid_cubit.dart';

abstract class TransactionidState extends Equatable {
  const TransactionidState();
}

class TransactionidInitial extends TransactionidState {
  @override
  List<Object> get props => [];
}

class TransactionidLoading extends TransactionidState {
  @override
  List<Object> get props => [];
}

class TransactionidSuccess extends TransactionidState {
  final TransactionModel transactionModel;

  const TransactionidSuccess({required this.transactionModel});

  @override
  List<Object> get props => [transactionModel];
}

class TransactionidFailure extends TransactionidState {
  final String? errorMessage;
  final AppErrorType errorType;

  const TransactionidFailure(
      {required this.errorType, required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
