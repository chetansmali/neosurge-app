part of 'remove_symbol_watchlist_cubit.dart';

abstract class RemoveSymbolWatchlistState extends Equatable {
  const RemoveSymbolWatchlistState();
}

class RemoveSymbolWatchlistInitial extends RemoveSymbolWatchlistState {
  @override
  List<Object> get props => [];
}

class RemoveSymbolWatchlistLoading extends RemoveSymbolWatchlistState {
  @override
  List<Object> get props => [];
}

class RemoveSymbolWatchlistSuccess extends RemoveSymbolWatchlistState {
  final DeleteSymbolModel deleteSymbolModel;

  const RemoveSymbolWatchlistSuccess({required this.deleteSymbolModel});

  @override
  List<Object> get props => [deleteSymbolModel];
}

class RemoveSymbolWatchlistFailure extends RemoveSymbolWatchlistState {
  final String? errorMessage;
  final AppErrorType errorType;

  const RemoveSymbolWatchlistFailure(
    this.errorType,
    this.errorMessage,
  );

  @override
  List<Object?> get props => [errorType, errorMessage];
}
