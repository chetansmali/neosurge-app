part of 'submit_retirement_otp_cubit.dart';

abstract class SubmitRetirementOtpState extends Equatable {
  const SubmitRetirementOtpState();
}

class SubmitRetirementOtpInitial extends SubmitRetirementOtpState {
  @override
  List<Object> get props => [];
}

class SubmitRetirementOtpLoading extends SubmitRetirementOtpState {
  @override
  List<Object> get props => [];
}

class SubmitRetirementOtpSuccess extends SubmitRetirementOtpState {
  final SubmitRetirementOTPModel submitRetirementOTPModel;

  const SubmitRetirementOtpSuccess(this.submitRetirementOTPModel);

  @override
  List<Object> get props => [submitRetirementOTPModel];
}

class SubmitRetirementOtpFailure extends SubmitRetirementOtpState {
  final String? errorMessage;
  final AppErrorType errorType;

  const SubmitRetirementOtpFailure(
      {required this.errorType, required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
