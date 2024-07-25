part of 'submit_import_otp_cubit.dart';

sealed class SubmitImportOtpState extends Equatable {
  const SubmitImportOtpState();
}

final class SubmitImportOtpInitial extends SubmitImportOtpState {
  @override
  List<Object> get props => [];
}

final class SubmitImportOtpLoading extends SubmitImportOtpState {
  @override
  List<Object> get props => [];
}

final class SubmitImportOtpSuccess extends SubmitImportOtpState {
  final GetImportLandingPageResponse getImportLandingPageResponse;

  const SubmitImportOtpSuccess({required this.getImportLandingPageResponse});

  @override
  List<Object> get props => [getImportLandingPageResponse];
}

final class SubmitImportOtpFailure extends SubmitImportOtpState {
  final String? errorMessage;
  final AppErrorType appErrorType;

  const SubmitImportOtpFailure({this.errorMessage, required this.appErrorType});

  @override
  List<Object?> get props => [appErrorType, errorMessage];
}
