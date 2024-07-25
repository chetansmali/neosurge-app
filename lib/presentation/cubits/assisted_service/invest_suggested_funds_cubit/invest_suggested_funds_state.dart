part of 'invest_suggested_funds_cubit.dart';

abstract class InvestSuggestedFundsState extends Equatable {
  const InvestSuggestedFundsState();
}

class InvestSuggestedFundsInitial extends InvestSuggestedFundsState {
  @override
  List<Object> get props => [];
}

class InvestSuggestedFundsLoading extends InvestSuggestedFundsState {
  @override
  List<Object> get props => [];
}

class InvestSuggestedFundsLoaded extends InvestSuggestedFundsState {
  final InvestSuggestedFundsResponse result;

  const InvestSuggestedFundsLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class InvestSuggestedFundsError extends InvestSuggestedFundsState {
  final String? error;
  final AppErrorType appErrorType;

  const InvestSuggestedFundsError(this.error, this.appErrorType);

  @override
  List<Object?> get props => [error, appErrorType];
}
