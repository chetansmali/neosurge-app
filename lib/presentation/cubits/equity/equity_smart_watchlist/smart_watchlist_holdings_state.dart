part of 'smart_watchlist_holdings_cubit.dart';

abstract class SmartWatchlistHoldingsState extends Equatable {
  const SmartWatchlistHoldingsState();
}

class SmartWatchlistHoldingsInitial extends SmartWatchlistHoldingsState {
  @override
  List<Object> get props => [];
}

class SmartWatchlistHoldingsLoading extends SmartWatchlistHoldingsState {
  @override
  List<Object> get props => [];
}

class SmartWatchlistHoldingsLoaded extends SmartWatchlistHoldingsState {
  final List<SmartWatchlistHoldingsModel> smartWatchlistHoldings;
  const SmartWatchlistHoldingsLoaded(this.smartWatchlistHoldings);

  @override
  List<Object> get props => [smartWatchlistHoldings];
}

class SmartWatchlistHoldingsFailure extends SmartWatchlistHoldingsState {
  final String? errorMessage;
  final AppErrorType errorType;

  const SmartWatchlistHoldingsFailure(
      {required this.errorType, required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
