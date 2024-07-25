part of 'basket_order_details_cubit.dart';

abstract class BasketOrderDetailsState extends Equatable {
  const BasketOrderDetailsState();
}

class BasketOrderDetailsInitial extends BasketOrderDetailsState {
  @override
  List<Object> get props => [];
}

class BasketOrderDetailsLoading extends BasketOrderDetailsState {
  @override
  List<Object> get props => [];
}

class BasketOrderDetailsLoaded extends BasketOrderDetailsState {
  final BasketOrderTransactionDetail basketOrderTransactionDetail;

  const BasketOrderDetailsLoaded({
    required this.basketOrderTransactionDetail,
  });

  @override
  List<Object> get props => [basketOrderTransactionDetail];
}

class BasketOrderDetailsError extends BasketOrderDetailsState {
  final String? message;
  final AppErrorType appErrorType;

  const BasketOrderDetailsError({
    required this.message,
    required this.appErrorType,
  });

  @override
  List<Object> get props => [];
}
