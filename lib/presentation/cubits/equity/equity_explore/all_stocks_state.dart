part of 'all_stocks_cubit.dart';

abstract class AllStocksState extends Equatable {
  const AllStocksState();
}

class AllStocksInitial extends AllStocksState {
  @override
  List<Object> get props => [];
}

class AllStocksLoading extends AllStocksState {
  final bool isInitialLoading;
  final List<AllStocksModel> oldStocksList;

  const AllStocksLoading({
    this.isInitialLoading = false,
    this.oldStocksList = const [],
  });

  @override
  List<Object> get props => [];
}

class AllStocksLoaded extends AllStocksState {
  final List<AllStocksModel> allStocksModel;
  final bool isLastPage;

  const AllStocksLoaded(
    this.allStocksModel,
    this.isLastPage,
  );

  @override
  List<Object> get props => [allStocksModel];
}

class AllStocksFailure extends AllStocksState {
  final List<AllStocksModel> allStocksModel;
  final String? errorMessage;
  final AppErrorType errorType;
  final bool isInitialLoading;

  const AllStocksFailure({
    required this.isInitialLoading,
    required this.allStocksModel,
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorType, errorMessage];
}
