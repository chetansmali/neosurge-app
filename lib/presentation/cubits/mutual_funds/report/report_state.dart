part of 'report_cubit.dart';

abstract class ReportState extends Equatable {
  const ReportState();
}

class ReportInitial extends ReportState {
  @override
  List<Object> get props => [];
}

class ReportGenerating extends ReportState {
  @override
  List<Object> get props => [];
}

class ReportGenerated extends ReportState {
  final String reportUrl;

  const ReportGenerated(this.reportUrl);

  @override
  List<Object> get props => [reportUrl];
}

class ReportGenerateError extends ReportState {
  final String? error;
  final AppErrorType errorType;

  const ReportGenerateError(this.error, this.errorType);

  @override
  List<Object?> get props => [error, errorType];
}
