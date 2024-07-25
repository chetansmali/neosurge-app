part of 'create_redeem_order_cubit.dart';

abstract class CreateRedeemOrderState extends Equatable {
  const CreateRedeemOrderState();
}

class CreateRedeemOrderInitial extends CreateRedeemOrderState {
  @override
  List<Object> get props => [];
}

class CreateRedeemOrderLoading extends CreateRedeemOrderState {
  @override
  List<Object> get props => [];
}

class CreateRedeemOrderSuccess extends CreateRedeemOrderState {
  final RedeemOrderResponse response;

  const CreateRedeemOrderSuccess({required this.response});

  @override
  List<Object> get props => [response];
}

class CreateRedeemOrderFailure extends CreateRedeemOrderState {
  final String? error;
  final AppErrorType errorType;

  const CreateRedeemOrderFailure(this.error, this.errorType);

  @override
  List<Object?> get props => [error, errorType];
}
