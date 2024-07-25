part of 'gold_chart_cubit.dart';

abstract class GoldChartState extends Equatable {
  final GoldSilverTimePeriod goldSilverTimePeriod;

  const GoldChartState(this.goldSilverTimePeriod);
}

class GoldChartInitial extends GoldChartState {
  const GoldChartInitial(GoldSilverTimePeriod goldSilverTimePeriod) : super(goldSilverTimePeriod);

  @override
  List<Object> get props => [goldSilverTimePeriod];
}

class GoldChartLoading extends GoldChartState {
  const GoldChartLoading(GoldSilverTimePeriod goldSilverTimePeriod) : super(goldSilverTimePeriod);

  @override
  List<Object?> get props => [goldSilverTimePeriod];
}

class GoldChartLoaded extends GoldChartState {
  final List<FlSpot> goldChartData;
  final List<String> dates;
  final List<DigitalGoldGraphResponse> digitalGoldGraphResponse;

  const GoldChartLoaded(GoldSilverTimePeriod goldSilverTimePeriod, {required this.goldChartData, required this.dates, required this.digitalGoldGraphResponse}) : super(goldSilverTimePeriod);

  @override
  List<Object?> get props => [goldSilverTimePeriod];
}

class GoldChartLoadError extends GoldChartState {
  final AppErrorType errorType;
  final String? errorMessage;

  const GoldChartLoadError(GoldSilverTimePeriod goldSilverTimePeriod, {required this.errorType, this.errorMessage}) : super(goldSilverTimePeriod);

  @override
  List<Object?> get props => [goldSilverTimePeriod];
}
