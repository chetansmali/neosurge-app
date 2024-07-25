part of 'stock_details_cubit.dart';

abstract class StockDetailsState extends Equatable {
  const StockDetailsState();
}

class StockDetailsInitial extends StockDetailsState {
  @override
  List<Object> get props => [];
}

class StockDetailsLoading extends StockDetailsState {
  @override
  List<Object> get props => [];
}

class StockDetailsSuccess extends StockDetailsState {
  final StockDetailsModel stockDetailsModel;

  const StockDetailsSuccess({required this.stockDetailsModel});

  @override
  List<Object> get props => [stockDetailsModel];
}

class StockDetailsFailure extends StockDetailsState {
  final String? errorMessage;
  final AppErrorType errorType;

  const StockDetailsFailure(
      {required this.errorType, required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
