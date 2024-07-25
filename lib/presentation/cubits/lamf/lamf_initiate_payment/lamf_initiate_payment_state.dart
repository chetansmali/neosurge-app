part of 'lamf_initiate_payment_cubit.dart';

sealed class LamfInitiatePaymentState extends Equatable {
  const LamfInitiatePaymentState();
}

final class LamfInitiatePaymentInitial extends LamfInitiatePaymentState {
  @override
  List<Object> get props => [];
}

final class LamfInitiatePaymentLoading extends LamfInitiatePaymentState {
  @override
  List<Object> get props => [];
}

final class LamfInitiatePaymentSuccess extends LamfInitiatePaymentState {
  const LamfInitiatePaymentSuccess({required this.initiatePaymentDetails});
  final InitiatePaymentDetails initiatePaymentDetails;

  @override
  List<Object> get props => [initiatePaymentDetails];
}

final class LamfInitiatePaymentFailure extends LamfInitiatePaymentState {
  final String? errorMessage;
  final AppErrorType errorType;

  const LamfInitiatePaymentFailure(this.errorMessage, this.errorType);
  @override
  List<Object?> get props => [errorMessage, errorType];
}
