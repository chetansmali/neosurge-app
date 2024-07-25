part of 'generate_retirement_otp_cubit.dart';

abstract class GenerateRetirementOtpState extends Equatable {
  const GenerateRetirementOtpState();
}

class GenerateRetirementOtpInitial extends GenerateRetirementOtpState {
  @override
  List<Object> get props => [];
}

class GenerateRetirementOtpLoading extends GenerateRetirementOtpState {
  @override
  List<Object> get props => [];
}

class GenerateRetirementOtpSuccess extends GenerateRetirementOtpState {
  final GenerateRetirementOTPModel generateRetirementOTPModel;

  const GenerateRetirementOtpSuccess(this.generateRetirementOTPModel);
  @override
  List<Object> get props => [generateRetirementOTPModel];
}

class GenerateRetirementOtpFailure extends GenerateRetirementOtpState {
  final String? errorMessage;
  final AppErrorType errorType;

  const GenerateRetirementOtpFailure(
      {required this.errorType, required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
