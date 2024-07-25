part of 'verify_cart_purchase_otp_cubit.dart';

abstract class VerifyCartPurchaseOtpState extends Equatable {
  const VerifyCartPurchaseOtpState();
}

class VerifyCartPurchaseOtpInitial extends VerifyCartPurchaseOtpState {
  const VerifyCartPurchaseOtpInitial();

  @override
  List<Object> get props => [];
}

class VerifyCartPurchaseOtpLoading extends VerifyCartPurchaseOtpState {
  const VerifyCartPurchaseOtpLoading();

  @override
  List<Object> get props => [];
}

class VerifyCartPurchaseOtpSuccess extends VerifyCartPurchaseOtpState {
  final VerifyCartPurchaseOtpResponse verifyCartPurchaseOtpResponse;

  const VerifyCartPurchaseOtpSuccess({
    required this.verifyCartPurchaseOtpResponse,
  });

  @override
  List<Object> get props => [verifyCartPurchaseOtpResponse];
}

class VerifyCartPurchaseOtpFailed extends VerifyCartPurchaseOtpState {
  final AppError error;

  const VerifyCartPurchaseOtpFailed({required this.error});

  @override
  List<Object> get props => [error];
}
