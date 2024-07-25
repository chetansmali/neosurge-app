part of 'sip_cart_cubit.dart';

abstract class SipCartState extends Equatable {
  final MutualFundCart? mutualFundCart;

  const SipCartState({
    this.mutualFundCart,
  });
}

class SipCartInitial extends SipCartState {
  @override
  List<Object> get props => [];
}

class SipCartFundsLoading extends SipCartState {
  @override
  List<Object> get props => [];
}

class SipCartFundsLoaded extends SipCartState {
  const SipCartFundsLoaded({required super.mutualFundCart});

  @override
  List<Object> get props => [];
}

class SipCartFundsLoadError extends SipCartState {
  final AppErrorType appErrorType;
  final String? error;

  const SipCartFundsLoadError({
    required this.appErrorType,
    required this.error,
  });

  @override
  List<Object> get props => [appErrorType, error ?? ''];
}

class RemoveFundFromSipCartLoading extends SipCartState {
  final int cartItemId;
  final MutualFundCart funds;

  const RemoveFundFromSipCartLoading({
    required this.cartItemId,
    required this.funds,
  }) : super(mutualFundCart: funds);

  @override
  List<Object> get props => [cartItemId];
}

class RemoveFundFromSipCartError extends SipCartState {
  final AppErrorType errorType;
  final String? error;

  const RemoveFundFromSipCartError({
    required this.errorType,
    required this.error,
  });

  @override
  List<Object> get props => [errorType, error ?? ''];
}
