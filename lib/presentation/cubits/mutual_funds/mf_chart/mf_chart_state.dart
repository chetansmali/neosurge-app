part of 'mf_chart_cubit.dart';

abstract class MFChartState extends Equatable {
  final MutualFundTimePeriod mutualFundTimePeriod;

  const MFChartState(this.mutualFundTimePeriod);
}

class MFChartInitial extends MFChartState {
  const MFChartInitial(MutualFundTimePeriod mutualFundTimePeriod) : super(mutualFundTimePeriod);

  @override
  List<Object> get props => [mutualFundTimePeriod];
}

class MFChartLoading extends MFChartState {
  const MFChartLoading(MutualFundTimePeriod mutualFundTimePeriod) : super(mutualFundTimePeriod);

  @override
  List<Object> get props => [mutualFundTimePeriod];
}

class MFChartLoaded extends MFChartState {
  final List<FlSpot> mfChartData;
  final List<String> dates;

  const MFChartLoaded(this.mfChartData, this.dates, MutualFundTimePeriod mutualFundTimePeriod) : super(mutualFundTimePeriod);

  @override
  List<Object> get props => [mfChartData, dates, mutualFundTimePeriod];
}

class MfChartLoadError extends MFChartState {
  final AppErrorType errorType;
  final String? errorMessage;

  const MfChartLoadError(this.errorType, this.errorMessage, MutualFundTimePeriod mutualFundTimePeriod) : super(mutualFundTimePeriod);

  @override
  List<Object?> get props => [mutualFundTimePeriod];
}
