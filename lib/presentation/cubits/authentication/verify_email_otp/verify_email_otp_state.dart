part of 'verify_email_otp_cubit.dart';

abstract class VerifyEmailOtpState extends Equatable {
  const VerifyEmailOtpState();
}

class VerifyEmailOtpInitial extends VerifyEmailOtpState {
  @override
  List<Object> get props => [];
}

class VerifyEmailOtpLoading extends VerifyEmailOtpState {
  @override
  List<Object> get props => [];
}

class VerifyEmailOtpSuccess extends VerifyEmailOtpState {
  final User user;

  const VerifyEmailOtpSuccess({required this.user});

  @override
  List<Object> get props => [];
}

class VerifyEmailOtpFailure extends VerifyEmailOtpState {
  final String? errorMessage;
  final AppErrorType errorType;

  const VerifyEmailOtpFailure({required this.errorType, this.errorMessage});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
