part of 'fund_holdings_cubit.dart';

abstract class FundHoldingsState extends Equatable {
  const FundHoldingsState();
}

class FundHoldingsInitial extends FundHoldingsState {
  @override
  List<Object> get props => [];
}

class FundHoldingsLoading extends FundHoldingsState {
  @override
  List<Object> get props => [];
}

class FundHoldingsLoaded extends FundHoldingsState {
  final List<FundHolding> holdings;

  const FundHoldingsLoaded({required this.holdings});

  @override
  List<Object> get props => [];
}

class FundHoldingsLoadError extends FundHoldingsState {
  final AppErrorType appErrorType;
  final String? errorMessage;

  const FundHoldingsLoadError({required this.appErrorType, this.errorMessage});

  @override
  List<Object?> get props => [appErrorType, errorMessage];
}
