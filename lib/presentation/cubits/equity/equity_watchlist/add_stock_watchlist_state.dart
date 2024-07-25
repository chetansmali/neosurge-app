part of 'add_stock_watchlist_cubit.dart';

abstract class AddStockWatchlistState extends Equatable {
  const AddStockWatchlistState();
}

class AddStockWatchlistInitial extends AddStockWatchlistState {
  @override
  List<Object> get props => [];
}

class AddStockWatchlistLoading extends AddStockWatchlistState {
  @override
  List<Object> get props => [];
}

class AddStockWatchlistLoaded extends AddStockWatchlistState {
  final AddStockWatchModel addStockWatchModel;

  const AddStockWatchlistLoaded({required this.addStockWatchModel});

  @override
  List<Object> get props => [addStockWatchModel];
}

class AddStockWatchlistFailure extends AddStockWatchlistState {
  final String? errorMessage;
  final AppErrorType errorType;

  const AddStockWatchlistFailure(
      {required this.errorType, required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
