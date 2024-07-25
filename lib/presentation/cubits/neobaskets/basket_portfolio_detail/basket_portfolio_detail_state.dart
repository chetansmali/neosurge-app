part of 'basket_portfolio_detail_cubit.dart';

abstract class BasketPortfolioDetailState extends Equatable {
  const BasketPortfolioDetailState();
}

class BasketPortfolioDetailInitial extends BasketPortfolioDetailState {
  @override
  List<Object> get props => [];
}

class BasketPortfolioDetailLoading extends BasketPortfolioDetailState {
  @override
  List<Object> get props => [];
}

class BasketPortfolioDetailLoaded extends BasketPortfolioDetailState {
  final BasketPortfolioDetailResponse basketPortfolioDetailResponse;

  const BasketPortfolioDetailLoaded({
    required this.basketPortfolioDetailResponse,
  });

  @override
  List<Object> get props => [basketPortfolioDetailResponse];
}

class BasketPortfolioDetailError extends BasketPortfolioDetailState {
  final String? errorMessage;
  final AppErrorType errorType;

  const BasketPortfolioDetailError({
    required this.errorMessage,
    required this.errorType,
  });

  @override
  List<Object> get props => [];
}
