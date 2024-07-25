part of 'get_investment_idea_filters_cubit.dart';

abstract class GetInvestmentIdeaFiltersState extends Equatable {
  const GetInvestmentIdeaFiltersState();
}

class GetInvestmentIdeaFiltersInitial extends GetInvestmentIdeaFiltersState {
  const GetInvestmentIdeaFiltersInitial();

  @override
  List<Object> get props => [];
}

class GetInvestmentIdeaFiltersLoading extends GetInvestmentIdeaFiltersState {
  const GetInvestmentIdeaFiltersLoading();

  @override
  List<Object> get props => [];
}

class GetInvestmentIdeaFiltersLoaded extends GetInvestmentIdeaFiltersState {
  final List<String> investmentIdeas;

  const GetInvestmentIdeaFiltersLoaded(this.investmentIdeas);

  @override
  List<Object> get props => [investmentIdeas];
}

class GetInvestmentIdeaFiltersError extends GetInvestmentIdeaFiltersState {
  final AppErrorType appErrorType;
  final String? error;

  const GetInvestmentIdeaFiltersError(
    this.appErrorType,
    this.error,
  );

  @override
  List<Object> get props => [appErrorType];
}
