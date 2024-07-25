part of 'basket_individual_redeem_order_cubit.dart';

abstract class BasketIndividualRedeemOrderState extends Equatable {
  const BasketIndividualRedeemOrderState();
}

class BasketIndividualRedeemOrderInitial
    extends BasketIndividualRedeemOrderState {
  @override
  List<Object> get props => [];
}

class BasketIndividualRedeemOrderLoading
    extends BasketIndividualRedeemOrderState {
  @override
  List<Object> get props => [];
}

class BasketIndividualRedeemOrderError
    extends BasketIndividualRedeemOrderState {
  final AppErrorType errorType;
  final String? message;

  const BasketIndividualRedeemOrderError({
    required this.errorType,
    this.message,
  });

  @override
  List<Object> get props => [];
}

class BasketIndividualRedeemOrderLoaded
    extends BasketIndividualRedeemOrderState {
  final BasketRedeemOrderResponse basketRedeemOrderResponse;

  const BasketIndividualRedeemOrderLoaded({
    required this.basketRedeemOrderResponse,
  });

  @override
  List<Object> get props => [basketRedeemOrderResponse];
}
