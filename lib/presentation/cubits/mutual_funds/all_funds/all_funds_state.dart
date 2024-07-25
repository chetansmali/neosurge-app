part of 'all_funds_cubit.dart';

abstract class AllFundsState extends Equatable {
  const AllFundsState();
}

class AllFundsInitial extends AllFundsState {
  @override
  List<Object> get props => [];
}

class AllFundsLoading extends AllFundsState {
  final bool isFirstFetch;
  final List<Fund> oldFundList;

  const AllFundsLoading(this.oldFundList, {this.isFirstFetch = false});

  @override
  List<Object> get props => [oldFundList, isFirstFetch];
}

class AllFundsLoaded extends AllFundsState {
  final List<Fund> fundList;
  final bool isLastPage;

  const AllFundsLoaded({required this.fundList, this.isLastPage = false});

  @override
  List<Object> get props => [fundList, isLastPage];
}

class AllFundsLoadError extends AllFundsState {
  final bool isFirstFetch;
  final List<Fund> oldFundList;
  final AppErrorType appErrorType;
  final String? errorMessage;

  const AllFundsLoadError({this.isFirstFetch = false, this.oldFundList = const [], required this.appErrorType, this.errorMessage});

  @override
  List<Object> get props => [oldFundList, isFirstFetch];
}
