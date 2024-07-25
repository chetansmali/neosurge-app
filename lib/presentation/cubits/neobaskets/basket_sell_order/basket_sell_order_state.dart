part of 'basket_sell_order_cubit.dart';

abstract class BasketSellOrderState extends Equatable {
  const BasketSellOrderState();
}

class BasketSellOrderInitial extends BasketSellOrderState {
  @override
  List<Object> get props => [];
}

class BasketSellOrderLoading extends BasketSellOrderState {
  @override
  List<Object> get props => [];
}

class BasketSellOrderLoaded extends BasketSellOrderState {
  final List<BasketSellOrder> basketOrders;

  const BasketSellOrderLoaded({required this.basketOrders});

  @override
  List<Object> get props => [basketOrders];
}

class BasketSellOrderError extends BasketSellOrderState {
  final AppErrorType appErrorType;
  final String? message;

  const BasketSellOrderError({
    required this.appErrorType,
    required this.message,
  });

  @override
  List<Object> get props => [];
}
