part of 'portfolio_holdings_cubit.dart';

abstract class PortfolioHoldingsState extends Equatable {
  const PortfolioHoldingsState();
}

class PortfolioHoldingsInitial extends PortfolioHoldingsState {
  @override
  List<Object> get props => [];
}

class PortfolioHoldingsLoading extends PortfolioHoldingsState {
  @override
  List<Object> get props => [];
}

class PortfolioHoldingsLoaded extends PortfolioHoldingsState {
  final PortfolioHoldingsModel portfolioHoldingsModel;

  const PortfolioHoldingsLoaded(this.portfolioHoldingsModel);
  @override
  List<Object> get props => [portfolioHoldingsModel];
}

class PortfolioHoldingsFailure extends PortfolioHoldingsState {
  final String? errorMessage;
  final AppErrorType errorType;

  const PortfolioHoldingsFailure(
      {required this.errorType, required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
