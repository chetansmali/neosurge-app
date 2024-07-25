part of 'search_fund_cubit.dart';

abstract class SearchFundState extends Equatable {
  const SearchFundState();
}

class SearchFundInitial extends SearchFundState {
  @override
  List<Object> get props => [];
}

class SearchFundLoading extends SearchFundState {
  final List<Fund> oldFunds;
  final bool isFirstFetch;

  const SearchFundLoading({
    required this.oldFunds,
    required this.isFirstFetch,
  });

  @override
  List<Object> get props => [];
}

class SearchFundLoaded extends SearchFundState {
  final List<Fund> funds;
  final bool isLastPage;

  const SearchFundLoaded({
    required this.funds,
    required this.isLastPage,
  });

  @override
  List<Object> get props => [funds];
}

class SearchFundLoadError extends SearchFundState {
  final String? errorMessage;
  final AppErrorType appErrorType;
  final List<Fund> oldFunds;

  const SearchFundLoadError({
    required this.oldFunds,
    required this.appErrorType,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [errorMessage, appErrorType];
}
