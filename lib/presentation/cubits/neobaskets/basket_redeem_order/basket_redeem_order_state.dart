part of 'basket_redeem_order_cubit.dart';

abstract class BasketRedeemOrderState extends Equatable {
  const BasketRedeemOrderState();
}

class BasketRedeemOrderInitial extends BasketRedeemOrderState {
  @override
  List<Object> get props => [];
}

class BasketRedeemOrderCreating extends BasketRedeemOrderState {
  @override
  List<Object> get props => [];
}

class BasketRedeemOrderCreated extends BasketRedeemOrderState {
  final BasketRedeemOrderResponse basketRedeemOrderResponse;

  const BasketRedeemOrderCreated(this.basketRedeemOrderResponse);

  @override
  List<Object> get props => [basketRedeemOrderResponse];
}

class BasketRedeemOrderError extends BasketRedeemOrderState {
  final AppErrorType errorType;
  final String? message;

  const BasketRedeemOrderError({
    required this.errorType,
    this.message,
  });

  @override
  List<Object> get props => [];
}
