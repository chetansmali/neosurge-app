part of 'basket_lumpsum_order_verify_cubit.dart';

abstract class BasketLumpsumOrderVerifyState extends Equatable {
  const BasketLumpsumOrderVerifyState();
}

class BasketLumpsumOrderVerifyInitial extends BasketLumpsumOrderVerifyState {
  const BasketLumpsumOrderVerifyInitial();

  @override
  List<Object?> get props => [];
}

class BasketLumpsumOrderVerifying extends BasketLumpsumOrderVerifyState {
  const BasketLumpsumOrderVerifying();

  @override
  List<Object?> get props => [];
}

class BasketLumpsumOrderVerified extends BasketLumpsumOrderVerifyState {
  const BasketLumpsumOrderVerified({
    required this.basketLumpsumOrderVerifyResponse,
  });

  final BasketLumpsumOrderVerifyResponse basketLumpsumOrderVerifyResponse;

  @override
  List<Object?> get props => [];
}

class BasketLumpsumOrderVerifyError extends BasketLumpsumOrderVerifyState {
  const BasketLumpsumOrderVerifyError({
    required this.errorType,
    this.error,
  });

  final AppErrorType errorType;
  final String? error;

  @override
  List<Object?> get props => [errorType, error];
}
