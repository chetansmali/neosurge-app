part of 'initiate_lumpsum_purchase_cubit.dart';

abstract class InitiateLumpsumPurchaseState extends Equatable {
  const InitiateLumpsumPurchaseState();
}

class InitiateLumpsumPurchaseInitial extends InitiateLumpsumPurchaseState {
  @override
  List<Object> get props => [];
}

class InitiateLumpsumPurchaseLoading extends InitiateLumpsumPurchaseState {
  @override
  List<Object> get props => [];
}

class InitiateLumpsumPurchaseSuccess extends InitiateLumpsumPurchaseState {
  final InitiatePaymentResponse response;

  const InitiateLumpsumPurchaseSuccess({required this.response});

  @override
  List<Object> get props => [response];
}

class InitiateLumpsumPurchaseFailure extends InitiateLumpsumPurchaseState {
  final AppErrorType errorType;
  final String? errorMessage;

  const InitiateLumpsumPurchaseFailure({required this.errorType, this.errorMessage});

  @override
  List<Object?> get props => [errorType, errorMessage];
}
