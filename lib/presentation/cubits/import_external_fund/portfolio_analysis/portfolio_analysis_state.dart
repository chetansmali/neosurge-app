part of 'portfolio_analysis_cubit.dart';

abstract class PortfolioAnalysisState extends Equatable {
  const PortfolioAnalysisState();

  @override
  List<Object> get props => [];
}

class PortfolioAnalysisInitial extends PortfolioAnalysisState {
  const PortfolioAnalysisInitial();
}

class PortfolioAnalysisLoading extends PortfolioAnalysisState {
  const PortfolioAnalysisLoading();
}

class PortfolioAnalysisLoaded extends PortfolioAnalysisState {
  final PortfolioAnalysisResponse portfolioAnalysisResponse;

  const PortfolioAnalysisLoaded(this.portfolioAnalysisResponse);

  @override
  List<Object> get props => [portfolioAnalysisResponse];
}

class PortfolioAnalysisError extends PortfolioAnalysisState {
  final AppError appError;

  const PortfolioAnalysisError(this.appError);

  @override
  List<Object> get props => [appError];
}
