part of 'switch_funds_list_cubit.dart';

abstract class SwitchFundsListState extends Equatable {
  const SwitchFundsListState();
}

class SwitchFundsListInitial extends SwitchFundsListState {
  @override
  List<Object> get props => [];
}

class SwitchFundsListLoading extends SwitchFundsListState {
  @override
  List<Object> get props => [];
}

class SwitchFundsListLoaded extends SwitchFundsListState {
  final List<Fund> funds;

  const SwitchFundsListLoaded(this.funds);

  @override
  List<Object> get props => [funds];
}

class SwitchFundsListError extends SwitchFundsListState {
  final AppErrorType errorType;
  final String? error;

  const SwitchFundsListError(this.errorType, this.error);

  @override
  List<Object?> get props => [errorType, error];
}
