part of 'lumpsum_cart_cubit.dart';

abstract class LumpsumCartState extends Equatable {
  final MutualFundCart? mutualFundCart;

  const LumpsumCartState({
    this.mutualFundCart,
  });
}

class LumpsumCartInitial extends LumpsumCartState {
  @override
  List<Object> get props => [];
}

class LumpsumCartFundsLoading extends LumpsumCartState {
  @override
  List<Object> get props => [];
}

class LumpsumCartFundsLoaded extends LumpsumCartState {
  const LumpsumCartFundsLoaded({required super.mutualFundCart});

  @override
  List<Object> get props => [];
}

class LumpsumCartFundsLoadError extends LumpsumCartState {
  final AppErrorType appErrorType;
  final String? error;

  const LumpsumCartFundsLoadError({
    required this.appErrorType,
    required this.error,
  });

  @override
  List<Object> get props => [appErrorType, error ?? ''];
}

class RemoveFundFromLumpsumCartLoading extends LumpsumCartState {
  final int cartItemId;
  final MutualFundCart funds;

  const RemoveFundFromLumpsumCartLoading({
    required this.cartItemId,
    required this.funds,
  }) : super(mutualFundCart: funds);

  @override
  List<Object> get props => [cartItemId];
}

class RemoveFundFromLumpsumCartError extends LumpsumCartState {
  final AppErrorType errorType;
  final String? error;

  const RemoveFundFromLumpsumCartError({
    required this.errorType,
    required this.error,
  });

  @override
  List<Object> get props => [errorType, error ?? ''];
}
