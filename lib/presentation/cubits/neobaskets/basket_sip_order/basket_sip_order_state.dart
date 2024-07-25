part of 'basket_sip_order_cubit.dart';

abstract class BasketSipOrderState extends Equatable {
  const BasketSipOrderState();
}

class BasketSipOrderInitial extends BasketSipOrderState {
  @override
  List<Object> get props => [];
}

class BasketSipOrderLoading extends BasketSipOrderState {
  @override
  List<Object> get props => [];
}

class BasketSipOrderSuccess extends BasketSipOrderState {
  final BasketOrderResponse basketOrderResponse;

  const BasketSipOrderSuccess(this.basketOrderResponse);

  @override
  List<Object> get props => [basketOrderResponse];
}

class BasketSipOrderFailure extends BasketSipOrderState {
  final AppErrorType errorType;
  final String? errorMessage;

  const BasketSipOrderFailure({
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object> get props => [];
}
