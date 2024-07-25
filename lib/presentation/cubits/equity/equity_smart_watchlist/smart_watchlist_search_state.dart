part of 'smart_watchlist_search_cubit.dart';

abstract class SmartWatchlistSearchState extends Equatable {
  const SmartWatchlistSearchState();
}

class SmartWatchlistSearchInitial extends SmartWatchlistSearchState {
  @override
  List<Object> get props => [];
}

class SmartWatchlistSearchLoading extends SmartWatchlistSearchState {
  final List<SmartWatchlistSearchModel> oldFunds;
  final bool isFirstFetch;

  const SmartWatchlistSearchLoading({
    required this.oldFunds,
    required this.isFirstFetch,
  });

  @override
  List<Object> get props => [];
}

class SmartWatchlistSearchLoaded extends SmartWatchlistSearchState {
  final List<SmartWatchlistSearchModel> funds;
  final bool isLastPage;

  const SmartWatchlistSearchLoaded({
    required this.funds,
    required this.isLastPage,
  });

  @override
  List<Object> get props => [];
}

class SmartWatchlistSearchLoadError extends SmartWatchlistSearchState {
  final String? errorMessage;
  final AppErrorType appErrorType;
  final List<SmartWatchlistSearchModel> oldFunds;

  const SmartWatchlistSearchLoadError({
    required this.oldFunds,
    required this.appErrorType,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [errorMessage, appErrorType];
}
