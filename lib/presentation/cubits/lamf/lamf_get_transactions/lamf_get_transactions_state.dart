part of 'lamf_get_transactions_cubit.dart';

abstract class LamfGetTransactionsState extends Equatable {
  const LamfGetTransactionsState();
}

final class LamfGetTransactionsInitial extends LamfGetTransactionsState {
  @override
  List<Object> get props => [];
}

class LamfGetTransactionsLoading extends LamfGetTransactionsState {
  @override
  List<Object> get props => [];
}

class LamfGetTransactionsSuccess extends LamfGetTransactionsState {
  GetTransactionsDetails getTransactionsDetails;
  LamfGetTransactionsSuccess(this.getTransactionsDetails);
  @override
  List<Object> get props => [];
}

class LamfGetTransactionsFailure extends LamfGetTransactionsState {
  final String? errorMessage;
  final AppErrorType errorType;

  const LamfGetTransactionsFailure(this.errorMessage, this.errorType);
  @override
  List<Object?> get props => [errorMessage, errorType];
}
