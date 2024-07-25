part of 'create_switch_order_cubit.dart';

abstract class CreateSwitchOrderState extends Equatable {
  const CreateSwitchOrderState();
}

class CreateSwitchOrderInitial extends CreateSwitchOrderState {
  @override
  List<Object> get props => [];
}

class CreateSwitchOrderLoading extends CreateSwitchOrderState {
  @override
  List<Object> get props => [];
}

class CreateSwitchOrderSuccess extends CreateSwitchOrderState {
  final SwitchOrderResponse response;

  const CreateSwitchOrderSuccess(this.response);

  @override
  List<Object> get props => [response];
}

class CreateSwitchOrderFailure extends CreateSwitchOrderState {
  final AppErrorType errorType;
  final String? errorMessage;

  const CreateSwitchOrderFailure(this.errorType, this.errorMessage);

  @override
  List<Object?> get props => [errorType, errorMessage];
}
