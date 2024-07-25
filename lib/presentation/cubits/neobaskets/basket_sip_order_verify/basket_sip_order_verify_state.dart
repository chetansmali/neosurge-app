part of 'basket_sip_order_verify_cubit.dart';

abstract class BasketSipOrderVerifyState extends Equatable {
  const BasketSipOrderVerifyState();
}

class BasketSipOrderVerifyInitial extends BasketSipOrderVerifyState {
  const BasketSipOrderVerifyInitial();

  @override
  List<Object?> get props => [];
}

class BasketSipOrderVerifying extends BasketSipOrderVerifyState {
  const BasketSipOrderVerifying();

  @override
  List<Object?> get props => [];
}

class BasketSipOrderVerified extends BasketSipOrderVerifyState {
  final BasketSipOrderVerifyResponse basketSipOrderVerifyResponse;

  const BasketSipOrderVerified({
    required this.basketSipOrderVerifyResponse,
  });

  @override
  List<Object?> get props => [];
}

class BasketSipOrderVerifyError extends BasketSipOrderVerifyState {
  const BasketSipOrderVerifyError({
    required this.errorType,
    this.error,
  });

  final AppErrorType errorType;
  final String? error;

  @override
  List<Object?> get props => [errorType, error];
}
