part of 'resend_otp_cubit.dart';

abstract class ResendOtpState extends Equatable {
  const ResendOtpState();
}

class ResendOtpInitial extends ResendOtpState {
  @override
  List<Object> get props => [];
}

class ResendOtpLoading extends ResendOtpState {
  @override
  List<Object> get props => [];
}

class ResendOtpSuccess extends ResendOtpState {
  @override
  List<Object> get props => [];
}

class ResendOtpFailure extends ResendOtpState {
  final String? error;
  final AppErrorType errorType;

  const ResendOtpFailure(this.error, this.errorType);

  @override
  List<Object?> get props => [error, errorType];
}
