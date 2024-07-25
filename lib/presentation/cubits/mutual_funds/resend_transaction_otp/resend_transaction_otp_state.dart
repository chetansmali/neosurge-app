part of 'resend_transaction_otp_cubit.dart';

abstract class ResendTransactionOtpState extends Equatable {
  const ResendTransactionOtpState();
}

class ResendTransactionOtpInitial extends ResendTransactionOtpState {
  @override
  List<Object> get props => [];
}

class ResendTransactionOtpLoading extends ResendTransactionOtpState {
  @override
  List<Object> get props => [];
}

class ResendTransactionOtpSuccess extends ResendTransactionOtpState {
  @override
  List<Object> get props => [];
}

class ResendTransactionOtpFailure extends ResendTransactionOtpState {
  final String? error;
  final AppErrorType errorType;

  const ResendTransactionOtpFailure(this.errorType, this.error);

  @override
  List<Object?> get props => [error, errorType];
}
