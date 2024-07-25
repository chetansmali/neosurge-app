part of 'mobile_otp_cubit.dart';

abstract class MobileOtpState extends Equatable {
  const MobileOtpState();
}

class MobileOtpInitial extends MobileOtpState {
  @override
  List<Object> get props => [];
}

class MobileOtpGenerating extends MobileOtpState {
  @override
  List<Object> get props => [];
}

class MobileOtpGenerateSuccess extends MobileOtpState {
  @override
  List<Object> get props => [];
}

class MobileOtpGenerateFailure extends MobileOtpState {
  final String? errorMessage;
  final AppErrorType errorType;

  const MobileOtpGenerateFailure({required this.errorMessage, required this.errorType});

  @override
  List<Object?> get props => [errorType, errorMessage];
}
