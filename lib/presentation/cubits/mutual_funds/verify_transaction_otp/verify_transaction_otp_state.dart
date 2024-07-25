part of 'verify_transaction_otp_cubit.dart';

abstract class VerifyTransactionOtpState extends Equatable {
  const VerifyTransactionOtpState();
}

class VerifyTransactionOtpInitial extends VerifyTransactionOtpState {
  @override
  List<Object> get props => [];
}

class VerifyTransactionOtpLoading extends VerifyTransactionOtpState {
  @override
  List<Object> get props => [];
}

class VerifyTransactionOtpSuccess extends VerifyTransactionOtpState {
  @override
  List<Object?> get props => [];
}

class VerifyTransactionOtpFailure extends VerifyTransactionOtpState {
  final String? error;
  final AppErrorType errorType;

  const VerifyTransactionOtpFailure(this.error, this.errorType);

  @override
  List<Object?> get props => [error, errorType];
}
