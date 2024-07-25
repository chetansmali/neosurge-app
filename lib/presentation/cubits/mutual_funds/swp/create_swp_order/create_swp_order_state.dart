part of 'create_swp_order_cubit.dart';

abstract class CreateSwpOrderState extends Equatable {
  const CreateSwpOrderState();
}

class CreateSwpOrderInitial extends CreateSwpOrderState {
  @override
  List<Object> get props => [];
}

class CreateSwpOrderLoading extends CreateSwpOrderState {
  @override
  List<Object> get props => [];
}

class CreateSwpOrderSuccess extends CreateSwpOrderState {
  final SwpOrderResponse swpOrderResponse;

  const CreateSwpOrderSuccess(this.swpOrderResponse);

  @override
  List<Object?> get props => [swpOrderResponse];
}

class CreateSwpOrderFailure extends CreateSwpOrderState {
  final String? error;
  final AppErrorType errorType;

  const CreateSwpOrderFailure(this.error, this.errorType);

  @override
  List<Object?> get props => [error, errorType];
}
