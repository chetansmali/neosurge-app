part of 'get_kyc_video_otp_cubit.dart';

abstract class GetKycVideoOtpState extends Equatable {
  const GetKycVideoOtpState();
}

class GetKycVideoOtpInitial extends GetKycVideoOtpState {
  @override
  List<Object> get props => [];
}

class GetKycVideoOtpLoading extends GetKycVideoOtpState {
  @override
  List<Object> get props => [];
}

class GetKycVideoOtpLoaded extends GetKycVideoOtpState {
  final String otp;

  const GetKycVideoOtpLoaded({required this.otp});

  @override
  List<Object> get props => [otp];
}

class GetKycVideoOtpFailure extends GetKycVideoOtpState {
  final String? errorMessage;
  final AppErrorType errorType;

  const GetKycVideoOtpFailure({this.errorMessage, required this.errorType});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
