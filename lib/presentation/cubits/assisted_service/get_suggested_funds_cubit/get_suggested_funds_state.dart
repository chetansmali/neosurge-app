part of 'get_suggested_funds_cubit.dart';

abstract class GetSuggestedFundsState extends Equatable {
  const GetSuggestedFundsState();
}

class GetSuggestedFundsInitial extends GetSuggestedFundsState {
  @override
  List<Object> get props => [];
}

class GetSuggestedFundsLoading extends GetSuggestedFundsState {
  @override
  List<Object> get props => [];
}

class GetSuggestedFundsLoaded extends GetSuggestedFundsState {
  final List<SuggestedFund> funds;

  const GetSuggestedFundsLoaded(this.funds);

  @override
  List<Object> get props => [funds];
}

class GetSuggestedFundsError extends GetSuggestedFundsState {
  final String? error;
  final AppErrorType appErrorType;

  const GetSuggestedFundsError(this.error, this.appErrorType);

  @override
  List<Object?> get props => [error, appErrorType];
}
