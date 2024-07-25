part of 'basket_lumpsum_order_cubit.dart';

abstract class BasketLumpsumOrderState extends Equatable {
  const BasketLumpsumOrderState();
}

class BasketLumpsumOrderInitial extends BasketLumpsumOrderState {
  @override
  List<Object> get props => [];
}

class BasketLumpsumOrderLoading extends BasketLumpsumOrderState {
  @override
  List<Object> get props => [];
}

class BasketLumpsumOrderSuccess extends BasketLumpsumOrderState {
  final BasketOrderResponse basketOrderResponse;

  const BasketLumpsumOrderSuccess(this.basketOrderResponse);

  @override
  List<Object> get props => [
        basketOrderResponse,
      ];
}

class BasketLumpsumOrderFailure extends BasketLumpsumOrderState {
  final String? errorMessage;
  final AppErrorType errorType;

  const BasketLumpsumOrderFailure({
    this.errorMessage,
    required this.errorType,
  });

  @override
  List<Object> get props => [];
}
