part of 'delivery_product_cubit.dart';

abstract class DeliveryProductState extends Equatable {
  const DeliveryProductState();
}

class DeliveryProductInitial extends DeliveryProductState {
  @override
  List<Object> get props => [];
}

class DeliveryProductLoading extends DeliveryProductState {
  @override
  List<Object> get props => [];
}

class DeliveryProductLoaded extends DeliveryProductState {
  final List<DeliveryProductModel> deliveryProducts;

  const DeliveryProductLoaded({required this.deliveryProducts});

  @override
  List<Object> get props => [deliveryProducts];
}

class DeliveryProductError extends DeliveryProductState {
  final AppErrorType appErrorType;
  final String? errorMessage;

  const DeliveryProductError({required this.appErrorType, this.errorMessage});

  @override
  List<Object?> get props => [appErrorType, errorMessage];
}
