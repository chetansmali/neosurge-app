part of 'mf_transactions_cubit.dart';

abstract class MfTransactionsState extends Equatable {
  const MfTransactionsState();
}

class MfTransactionsInitial extends MfTransactionsState {
  @override
  List<Object> get props => [];
}

class MfTransactionsLoading extends MfTransactionsState {
  @override
  List<Object> get props => [];
}

class MfTransactionsLoaded extends MfTransactionsState {
  final MfTransaction mfTransaction;

  const MfTransactionsLoaded(this.mfTransaction);

  @override
  List<Object> get props => [mfTransaction];
}

class MfTransactionsError extends MfTransactionsState {
  final AppErrorType errorType;
  final String? errorMessage;

  const MfTransactionsError(this.errorType, this.errorMessage);

  @override
  List<Object?> get props => [errorType, errorMessage];
}
