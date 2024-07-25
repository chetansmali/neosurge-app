part of 'initiate_suggested_funds_payment_cubit.dart';

abstract class InitiateSuggestedFundsPaymentState extends Equatable {
  const InitiateSuggestedFundsPaymentState();
}

class InitiateSuggestedFundsPaymentInitial extends InitiateSuggestedFundsPaymentState {
  @override
  List<Object> get props => [];
}

class InitiateSuggestedFundsPaymentLoading extends InitiateSuggestedFundsPaymentState {
  @override
  List<Object> get props => [];
}

class InitiateSuggestedFundsPaymentSuccess extends InitiateSuggestedFundsPaymentState {
  final InitiatePaymentResponse response;

  const InitiateSuggestedFundsPaymentSuccess({required this.response});

  @override
  List<Object> get props => [response];
}

class InitiateSuggestedFundsPaymentFailure extends InitiateSuggestedFundsPaymentState {
  final AppErrorType errorType;
  final String? errorMessage;

  const InitiateSuggestedFundsPaymentFailure({required this.errorType, this.errorMessage});

  @override
  List<Object?> get props => [errorType, errorMessage];
}
