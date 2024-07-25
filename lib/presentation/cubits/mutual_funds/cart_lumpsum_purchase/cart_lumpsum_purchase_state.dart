part of 'cart_lumpsum_purchase_cubit.dart';

abstract class CartLumpsumPurchaseState extends Equatable {
  const CartLumpsumPurchaseState();
}

class CartLumpsumPurchaseInitial extends CartLumpsumPurchaseState {
  @override
  List<Object> get props => [];
}

class CartLumpsumPurchaseLoading extends CartLumpsumPurchaseState {
  @override
  List<Object> get props => [];
}

class CartLumpsumPurchaseSuccess extends CartLumpsumPurchaseState {
  final InitiateCartPurchaseResponse initiateCartLumpsumPurchaseResponse;

  const CartLumpsumPurchaseSuccess(this.initiateCartLumpsumPurchaseResponse);

  @override
  List<Object> get props => [initiateCartLumpsumPurchaseResponse];
}

class CartLumpsumPurchaseError extends CartLumpsumPurchaseState {
  final AppError appError;

  const CartLumpsumPurchaseError(this.appError);

  @override
  List<Object> get props => [appError];
}
