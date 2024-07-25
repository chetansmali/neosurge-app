part of 'basket_portfolio_cubit.dart';

abstract class BasketPortfolioState extends Equatable {
  const BasketPortfolioState();
}

class BasketPortfolioInitial extends BasketPortfolioState {
  @override
  List<Object> get props => [];
}

class BasketPortfolioLoading extends BasketPortfolioState {
  @override
  List<Object> get props => [];
}

class BasketPortfolioLoaded extends BasketPortfolioState {
  final BasketPortfolioResponse basketPortfolioResponse;

  const BasketPortfolioLoaded(this.basketPortfolioResponse);

  @override
  List<Object> get props => [basketPortfolioResponse];
}

class BasketPortfolioError extends BasketPortfolioState {
  final AppErrorType errorType;
  final String? errorMessage;

  const BasketPortfolioError({
    required this.errorType,
    this.errorMessage,
  });

  @override
  List<Object> get props => [];
}
