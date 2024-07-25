part of 'etf_stocks_cubit.dart';

sealed class EtfStocksState extends Equatable {
  const EtfStocksState();
}

final class EtfStocksInitial extends EtfStocksState {
  @override
  List<Object> get props => [];
}

class EtfStocksLoading extends EtfStocksState {
  final bool isInitialLoading;
  final List<ETFStocksModel> oldStocksList;

  const EtfStocksLoading({
    this.isInitialLoading = false,
    this.oldStocksList = const [],
  });

  @override
  List<Object> get props => [];
}

class EtfStocksLoaded extends EtfStocksState {
  final List<ETFStocksModel> etfStocksModel;
  final bool isLastPage;

  const EtfStocksLoaded(
    this.etfStocksModel,
    this.isLastPage,
  );

  @override
  List<Object> get props => [etfStocksModel];
}

class EtfStocksFailure extends EtfStocksState {
  final List<ETFStocksModel> allStocksModel;
  final String? errorMessage;
  final AppErrorType errorType;
  final bool isInitialLoading;

  const EtfStocksFailure({
    required this.isInitialLoading,
    required this.allStocksModel,
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorType, errorMessage];
}
