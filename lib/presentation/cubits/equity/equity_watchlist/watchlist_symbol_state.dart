part of 'watchlist_symbol_cubit.dart';

abstract class WatchlistSymbolState extends Equatable {
  const WatchlistSymbolState();
}

class WatchlistSymbolInitial extends WatchlistSymbolState {
  @override
  List<Object> get props => [];
}

class WatchlistSymbolLoading extends WatchlistSymbolState {
  @override
  List<Object> get props => [];
}

class WatchlistSymbolLoaded extends WatchlistSymbolState {
  final List<WatchlistStocksModel> watchlistStocksModel;

  const WatchlistSymbolLoaded(
    this.watchlistStocksModel,
  );
  @override
  List<Object> get props => [watchlistStocksModel];
}

class WatchlistSymbolFailure extends WatchlistSymbolState {
  final String? errorMessage;
  final AppErrorType errorType;
  final int watchlistId;

  const WatchlistSymbolFailure(
    this.errorType,
    this.errorMessage,
    this.watchlistId,
  );

  @override
  List<Object?> get props => [errorType, errorMessage];
}
