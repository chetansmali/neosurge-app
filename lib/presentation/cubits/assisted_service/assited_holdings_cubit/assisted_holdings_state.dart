part of 'assisted_holdings_cubit.dart';

abstract class AssistedHoldingsState extends Equatable {
  const AssistedHoldingsState();
}

class AssistedHoldingsInitial extends AssistedHoldingsState {
  @override
  List<Object> get props => [];
}

class AssistedHoldingsLoading extends AssistedHoldingsState {
  @override
  List<Object> get props => [];
}

class AssistedHoldingsLoaded extends AssistedHoldingsState {
  final UserMfHoldings? userMfHoldings;

  const AssistedHoldingsLoaded(this.userMfHoldings);

  @override
  List<Object?> get props => [userMfHoldings];
}

class AssistedHoldingsError extends AssistedHoldingsState {
  final AppErrorType errorType;
  final String? error;

  const AssistedHoldingsError(this.errorType, this.error);

  @override
  List<Object?> get props => [errorType, error];
}
