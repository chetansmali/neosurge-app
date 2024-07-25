part of 'verify_mobile_otp_cubit.dart';

abstract class VerifyMobileOtpState extends Equatable {
  const VerifyMobileOtpState();
}

class VerifyMobileOtpInitial extends VerifyMobileOtpState {
  @override
  List<Object> get props => [];
}

class VerifyMobileOtpLoading extends VerifyMobileOtpState {
  @override
  List<Object> get props => [];
}

class VerifyMobileOtpSuccess extends VerifyMobileOtpState {
  @override
  List<Object> get props => [];
}

class VerifyMobileOtpFailure extends VerifyMobileOtpState {
  final AppErrorType errorType;
  final String? errorMessage;

  const VerifyMobileOtpFailure({required this.errorType, this.errorMessage});

  @override
  List<Object?> get props => [errorType, errorMessage];
}
