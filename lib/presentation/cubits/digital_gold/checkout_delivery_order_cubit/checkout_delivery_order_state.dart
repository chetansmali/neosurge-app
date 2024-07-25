part of 'checkout_delivery_order_cubit.dart';

abstract class CheckoutDeliveryOrderState extends Equatable {
  const CheckoutDeliveryOrderState();
}

class CheckoutDeliveryOrderInitial extends CheckoutDeliveryOrderState {
  @override
  List<Object> get props => [];
}

class CheckoutDeliveryOrderLoading extends CheckoutDeliveryOrderState {
  @override
  List<Object> get props => [];
}

class CheckoutDeliveryOrderSuccess extends CheckoutDeliveryOrderState {
  final CheckoutDeliveryResponseModel checkoutDeliveryResponseModel;

  const CheckoutDeliveryOrderSuccess(this.checkoutDeliveryResponseModel);

  @override
  List<Object> get props => [checkoutDeliveryResponseModel];
}

class CheckoutDeliveryOrderFailure extends CheckoutDeliveryOrderState {
  final AppErrorType appErrorType;
  final String? errorMessage;

  const CheckoutDeliveryOrderFailure({required this.appErrorType, this.errorMessage});

  @override
  List<Object?> get props => [appErrorType, errorMessage];
}
