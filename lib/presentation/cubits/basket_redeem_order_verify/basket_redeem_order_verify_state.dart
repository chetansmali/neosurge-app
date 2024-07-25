part of 'basket_redeem_order_verify_cubit.dart';

abstract class BasketRedeemOrderVerifyState extends Equatable {
  const BasketRedeemOrderVerifyState();
}

class BasketRedeemOrderVerifyInitial extends BasketRedeemOrderVerifyState {
  @override
  List<Object> get props => [];
}

class BasketRedeemOrderVerifying extends BasketRedeemOrderVerifyState {
  @override
  List<Object> get props => [];
}

class BasketRedeemOrderVerified extends BasketRedeemOrderVerifyState {
  const BasketRedeemOrderVerified();

  @override
  List<Object> get props => [];
}

class BasketRedeemOrderVerifyError extends BasketRedeemOrderVerifyState {
  final String? error;
  final AppErrorType appErrorType;

  const BasketRedeemOrderVerifyError({
    required this.appErrorType,
    this.error,
  });

  @override
  List<Object> get props => [];
}
