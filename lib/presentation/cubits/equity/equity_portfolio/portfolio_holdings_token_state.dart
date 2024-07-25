part of 'portfolio_holdings_token_cubit.dart';

sealed class PortfolioHoldingsTokenState extends Equatable {
  const PortfolioHoldingsTokenState();
}

class PortfolioHoldingsTokenInitial extends PortfolioHoldingsTokenState {
  @override
  List<Object> get props => [];
}

class PortfolioHoldingsTokenLoading extends PortfolioHoldingsTokenState {
  @override
  List<Object> get props => [];
}

class PortfolioHoldingsTokenLoaded extends PortfolioHoldingsTokenState {
  final GetFundsModel getFundsModel;

  const PortfolioHoldingsTokenLoaded(this.getFundsModel);
  @override
  List<Object> get props => [getFundsModel];
}

class PortfolioHoldingsTokenFailure extends PortfolioHoldingsTokenState {
  final String? errorMessage;
  final AppErrorType errorType;

  const PortfolioHoldingsTokenFailure(
      {required this.errorType, required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
