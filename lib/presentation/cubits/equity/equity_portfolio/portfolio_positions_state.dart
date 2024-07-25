part of 'portfolio_positions_cubit.dart';

abstract class PortfolioPositionsState extends Equatable {
  const PortfolioPositionsState();
}

class PortfolioPositionsInitial extends PortfolioPositionsState {
  @override
  List<Object> get props => [];
}

class PortfolioPositionsLoading extends PortfolioPositionsState {
  @override
  List<Object> get props => [];
}

class PortfolioPositionsLoaded extends PortfolioPositionsState {
  final PortfolioPositionModel portfolioPositionModel;

  const PortfolioPositionsLoaded(this.portfolioPositionModel);

  @override
  List<Object> get props => [portfolioPositionModel];
}

class PortfolioPositionsFailure extends PortfolioPositionsState {
  final String? errorMessage;
  final AppErrorType errorType;

  const PortfolioPositionsFailure(
      {required this.errorType, required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
