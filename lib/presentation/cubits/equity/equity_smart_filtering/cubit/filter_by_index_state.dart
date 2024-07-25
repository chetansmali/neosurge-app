part of 'filter_by_index_cubit.dart';

sealed class FilterByIndexState extends Equatable {
  const FilterByIndexState();
}

class FilterByIndexInitial extends FilterByIndexState {
  @override
  List<Object> get props => [];
}

class FilterByIndexLoading extends FilterByIndexState {
  final bool isInitialLoading;
  final List<SubsidiaryModel> oldStocksList;

  const FilterByIndexLoading({
    this.isInitialLoading = false,
    this.oldStocksList = const [],
  });

  @override
  List<Object> get props => [];
}

class FilterByIndexSuccess extends FilterByIndexState {
  final StocksByIndexModel stocksByIndex;
  final bool isLastPage;

  const FilterByIndexSuccess({
    required this.stocksByIndex,
    required this.isLastPage,
  });

  @override
  List<Object> get props => [stocksByIndex];
}

class FilterByIndexFailure extends FilterByIndexState {
  final List<SubsidiaryModel> allStocksModel;
  final bool isInitialLoading;
  final String? errorMessage;
  final AppErrorType errorType;

  const FilterByIndexFailure({
    required this.isInitialLoading,
    required this.allStocksModel,
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorMessage, errorType];
}
