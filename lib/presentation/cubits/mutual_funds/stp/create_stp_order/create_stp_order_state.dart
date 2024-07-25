part of 'create_stp_order_cubit.dart';

abstract class CreateStpOrderState extends Equatable {
  const CreateStpOrderState();
}

class CreateStpOrderInitial extends CreateStpOrderState {
  @override
  List<Object> get props => [];
}

class CreateStpOrderLoading extends CreateStpOrderState {
  @override
  List<Object> get props => [];
}

class CreateStpOrderSuccess extends CreateStpOrderState {
  final StpOrderResponse stpOrderResponse;

  const CreateStpOrderSuccess(this.stpOrderResponse);

  @override
  List<Object> get props => [stpOrderResponse];
}

class CreateStpOrderFailure extends CreateStpOrderState {
  final AppErrorType errorType;
  final String? error;

  const CreateStpOrderFailure(this.error, this.errorType);

  @override
  List<Object?> get props => [error, errorType];
}
