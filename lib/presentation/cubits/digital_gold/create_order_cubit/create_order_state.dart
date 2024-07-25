part of 'create_order_cubit.dart';

abstract class CreateOrderState extends Equatable {
  const CreateOrderState();
}

class CreateOrderInitial extends CreateOrderState {
  @override
  List<Object> get props => [];
}

class CreateOrderLoading extends CreateOrderState {
  @override
  List<Object> get props => [];
}

class CreateOrderLoaded extends CreateOrderState {
  final CreateOrderResponseModel createOrderResponseModel;

  const CreateOrderLoaded({required this.createOrderResponseModel});

  @override
  List<Object> get props => [createOrderResponseModel];
}

class CreateOrderLoadError extends CreateOrderState {
  final String? errorMessage;
  final AppErrorType errorType;

  const CreateOrderLoadError({
    this.errorMessage,
    required this.errorType,
  });

  @override
  List<Object> get props => [];
}
