part of 'stock_chart_cubit.dart';

abstract class StockChartState extends Equatable {
  final EquityChartTimePeriod equityTimePeriod;
  const StockChartState(this.equityTimePeriod);
}

class StockChartInitial extends StockChartState {
  const StockChartInitial(EquityChartTimePeriod equityTimePeriod)
      : super(equityTimePeriod);

  @override
  List<Object> get props => [equityTimePeriod];
}

class StockChartLoading extends StockChartState {
  const StockChartLoading(EquityChartTimePeriod equityTimePeriod)
      : super(equityTimePeriod);

  @override
  List<Object> get props => [equityTimePeriod];
}

class StockChartSuccess extends StockChartState {
  final List<FlSpot> stockChartData;
  final List<DateTime> dates;

  const StockChartSuccess(
    this.stockChartData,
    this.dates,
    EquityChartTimePeriod equityTimePeriod,
  ) : super(equityTimePeriod);

  @override
  List<Object> get props => [stockChartData, dates, equityTimePeriod];
}

class StockChartFailure extends StockChartState {
  final String? errorMessage;
  final AppErrorType errorType;

  const StockChartFailure(
    this.errorType,
    this.errorMessage,
    EquityChartTimePeriod equityTimePeriod,
  ) : super(equityTimePeriod);

  @override
  List<Object?> get props => [errorType, errorMessage, equityTimePeriod];
}
