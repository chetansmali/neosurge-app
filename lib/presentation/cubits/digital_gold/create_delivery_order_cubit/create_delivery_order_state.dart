part of 'create_delivery_order_cubit.dart';

abstract class CreateDeliveryOrderState extends Equatable {
  const CreateDeliveryOrderState();
}

class CreateDeliveryOrderInitial extends CreateDeliveryOrderState {
  @override
  List<Object> get props => [];
}

class CreateDeliveryOrderLoading extends CreateDeliveryOrderState {
  @override
  List<Object> get props => [];
}

class CreateDeliveryOrderSuccess extends CreateDeliveryOrderState {
  final CreateOrderResponseModel orderResponse;

  const CreateDeliveryOrderSuccess({required this.orderResponse});

  @override
  List<Object> get props => [orderResponse];
}

class CreateDeliveryOrderFailure extends CreateDeliveryOrderState {
  final AppErrorType appErrorType;
  final String? errorMessage;

  const CreateDeliveryOrderFailure({this.errorMessage, required this.appErrorType});

  @override
  List<Object?> get props => [appErrorType, errorMessage];
}
