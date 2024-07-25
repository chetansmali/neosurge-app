part of 'get_alert_details_cubit.dart';

abstract class GetAlertDetailsState extends Equatable {
  const GetAlertDetailsState();
}

class GetAlertDetailsInitial extends GetAlertDetailsState {
  @override
  List<Object> get props => [];
}

class GetAlertDetailsLoading extends GetAlertDetailsState {
  @override
  List<Object> get props => [];
}

class GetAlertDetailsLoaded extends GetAlertDetailsState {
  AlertDetailsModel alertDetailsModel;
  final List<FlSpot> stockChartData;
  final List<DateTime> dates;
  final List<int> spotIndexies;

  GetAlertDetailsLoaded(
    this.alertDetailsModel,
    this.stockChartData,
    this.dates,
    this.spotIndexies,
  );
  @override
  List<Object> get props =>
      [alertDetailsModel, stockChartData, dates, spotIndexies];
}

class GetAlertDetailsFailure extends GetAlertDetailsState {
  final String? errorMessage;
  final AppErrorType errorType;

  const GetAlertDetailsFailure(
      {required this.errorType, required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
