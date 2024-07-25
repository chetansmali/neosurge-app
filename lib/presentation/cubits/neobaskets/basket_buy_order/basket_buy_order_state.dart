part of 'basket_buy_order_cubit.dart';

abstract class BasketBuyOrderState extends Equatable {
  const BasketBuyOrderState();
}

class BasketBuyOrderInitial extends BasketBuyOrderState {
  @override
  List<Object> get props => [];
}

class BasketBuyOrderLoading extends BasketBuyOrderState {
  @override
  List<Object> get props => [];
}

class BasketBuyOrderLoaded extends BasketBuyOrderState {
  final List<BasketBuyOrder> basketOrders;

  const BasketBuyOrderLoaded({required this.basketOrders});

  @override
  List<Object> get props => [basketOrders];
}

class BasketBuyOrderError extends BasketBuyOrderState {
  final AppErrorType appErrorType;
  final String? message;

  const BasketBuyOrderError({
    required this.appErrorType,
    required this.message,
  });

  @override
  List<Object> get props => [];
}
