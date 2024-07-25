part of 'get_funds_by_investment_idea_cubit.dart';

abstract class GetFundsByInvestmentIdeaState extends Equatable {
  final List<MutualFund>? fundList;

  const GetFundsByInvestmentIdeaState({
    this.fundList,
  });
}

class GetFundsByInvestmentIdeaInitial extends GetFundsByInvestmentIdeaState {
  const GetFundsByInvestmentIdeaInitial();

  @override
  List<Object> get props => [];
}

class GetFundsByInvestmentIdeaLoading extends GetFundsByInvestmentIdeaState {
  final bool isFirstFetch;

  const GetFundsByInvestmentIdeaLoading({
    List<MutualFund>? oldFundList,
    required this.isFirstFetch,
  }) : super(
          fundList: oldFundList,
        );

  @override
  List<Object> get props => [];
}

class GetFundsByInvestmentIdeaLoaded extends GetFundsByInvestmentIdeaState {
  final List<MutualFund> newFundList;
  final bool isLastPage;

  const GetFundsByInvestmentIdeaLoaded({
    required this.newFundList,
    required this.isLastPage,
  }) : super(
          fundList: newFundList,
        );

  @override
  List<Object> get props => [newFundList, isLastPage];
}

class GetFundsByInvestmentIdeaLoadFailure
    extends GetFundsByInvestmentIdeaState {
  final List<MutualFund> oldFundList;
  final AppErrorType errorType;
  final String? error;

  const GetFundsByInvestmentIdeaLoadFailure({
    required this.oldFundList,
    required this.errorType,
    required this.error,
  }) : super(
          fundList: oldFundList,
        );

  @override
  List<Object> get props => [errorType, error ?? '', oldFundList];
}
