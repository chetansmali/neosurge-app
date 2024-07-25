part of 'stp_funds_list_cubit.dart';

abstract class StpFundsListState extends Equatable {
  const StpFundsListState();
}

class StpFundsListInitial extends StpFundsListState {
  @override
  List<Object> get props => [];
}

class StpFundsListLoading extends StpFundsListState {
  @override
  List<Object> get props => [];
}

class StpFundsListLoaded extends StpFundsListState {
  final List<Fund> funds;

  const StpFundsListLoaded(this.funds);

  @override
  List<Object> get props => [funds];
}

class StpFundsListError extends StpFundsListState {
  final AppErrorType errorType;
  final String? error;

  const StpFundsListError(this.errorType, this.error);

  @override
  List<Object?> get props => [errorType, error];
}
