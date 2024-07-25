part of 'cart_sip_purchase_cubit.dart';

abstract class CartSipPurchaseState extends Equatable {
  const CartSipPurchaseState();
}

class CartSipPurchaseInitial extends CartSipPurchaseState {
  @override
  List<Object> get props => [];
}

class CartSipPurchaseLoading extends CartSipPurchaseState {
  @override
  List<Object> get props => [];
}

class CartSipPurchaseSuccess extends CartSipPurchaseState {
  final InitiateCartPurchaseResponse initiateCartSipPurchaseResponse;

  const CartSipPurchaseSuccess(this.initiateCartSipPurchaseResponse);

  @override
  List<Object> get props => [initiateCartSipPurchaseResponse];
}

class CartSipPurchaseError extends CartSipPurchaseState {
  final AppError appError;

  const CartSipPurchaseError(this.appError);

  @override
  List<Object> get props => [appError];
}
