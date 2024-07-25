part of 'get_capital_gain_report_cubit.dart';

abstract class GetCapitalGainReportState extends Equatable {
  const GetCapitalGainReportState();
}

class GetCapitalGainReportInitial extends GetCapitalGainReportState {
  @override
  List<Object> get props => [];
}

class GetCapitalGainReportLoading extends GetCapitalGainReportState {
  @override
  List<Object> get props => [];
}

class GetCapitalGainReportLoaded extends GetCapitalGainReportState {
  final CapitalGainReportModel capitalGainReportModel;

  const GetCapitalGainReportLoaded(this.capitalGainReportModel);

  @override
  List<Object> get props => [capitalGainReportModel];
}

class GetCapitalGainReportFailure extends GetCapitalGainReportState {
  final AppErrorType appErrorType;
  final String? errorMessage;

  const GetCapitalGainReportFailure(
      {required this.appErrorType, required this.errorMessage});

  @override
  List<Object?> get props => [appErrorType, errorMessage];
}
