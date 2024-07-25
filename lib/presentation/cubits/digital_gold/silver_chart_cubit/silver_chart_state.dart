part of 'silver_chart_cubit.dart';

abstract class SilverChartState extends Equatable {
  final GoldSilverTimePeriod goldSilverTimePeriod;

  const SilverChartState(this.goldSilverTimePeriod);
}

class SilverChartInitial extends SilverChartState {
  const SilverChartInitial(GoldSilverTimePeriod goldSilverTimePeriod) : super(goldSilverTimePeriod);

  @override
  List<Object> get props => [goldSilverTimePeriod];
}

class SilverChartLoading extends SilverChartState {
  const SilverChartLoading(GoldSilverTimePeriod goldSilverTimePeriod) : super(goldSilverTimePeriod);

  @override
  List<Object?> get props => [goldSilverTimePeriod];
}

class SilverChartLoaded extends SilverChartState {
  final List<String> dates;
  final List<FlSpot> silverChartData;
  final List<DigitalGoldGraphResponse> digitalGoldGraphResponse;

  const SilverChartLoaded(GoldSilverTimePeriod goldSilverTimePeriod, {required this.silverChartData, required this.dates, required this.digitalGoldGraphResponse}) : super(goldSilverTimePeriod);

  @override
  List<Object?> get props => [goldSilverTimePeriod];
}

class SilverChartLoadError extends SilverChartState {
  final AppErrorType errorType;
  final String? errorMessage;

  const SilverChartLoadError(GoldSilverTimePeriod goldSilverTimePeriod, {required this.errorType, this.errorMessage}) : super(goldSilverTimePeriod);

  @override
  List<Object?> get props => [goldSilverTimePeriod];
}
