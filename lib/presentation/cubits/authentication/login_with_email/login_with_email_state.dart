part of 'login_with_email_cubit.dart';

abstract class LoginWithEmailState extends Equatable {
  const LoginWithEmailState();
}

class LoginWithEmailInitial extends LoginWithEmailState {
  @override
  List<Object> get props => [];
}

class LoginWithEmailLoading extends LoginWithEmailState {
  @override
  List<Object> get props => [];
}

class LoginWithEmailOtpGenerated extends LoginWithEmailState {
  final bool isResend;
  final LoginWithEmailResponseModel response;

  const LoginWithEmailOtpGenerated({this.isResend = false, required this.response});

  @override
  List<Object> get props => [isResend];
}

class LoginWithEmailOtpGenerateError extends LoginWithEmailState {
  final String? errorMessage;
  final AppErrorType errorType;

  const LoginWithEmailOtpGenerateError({this.errorMessage, required this.errorType});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
