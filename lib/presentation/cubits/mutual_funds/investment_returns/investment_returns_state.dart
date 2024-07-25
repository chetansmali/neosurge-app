part of 'investment_returns_cubit.dart';

abstract class InvestmentReturnsState extends Equatable {
  const InvestmentReturnsState();
}

class InvestmentReturnsInitial extends InvestmentReturnsState {
  @override
  List<Object> get props => [];
}

class InvestmentReturnsLoading extends InvestmentReturnsState {
  @override
  List<Object> get props => [];
}

class InvestmentReturnsLoaded extends InvestmentReturnsState {
  final InvestmentReturns investmentReturns;

  const InvestmentReturnsLoaded(this.investmentReturns);

  @override
  List<Object> get props => [investmentReturns];
}

class InvestmentReturnsLoadError extends InvestmentReturnsState {
  final AppErrorType errorType;
  final String? errorMessage;

  const InvestmentReturnsLoadError(this.errorType, this.errorMessage);

  @override
  List<Object?> get props => [errorType, errorMessage];
}
