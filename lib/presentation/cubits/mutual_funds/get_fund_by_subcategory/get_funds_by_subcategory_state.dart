part of 'get_funds_by_subcategory_cubit.dart';

abstract class GetFundBySubcategoryState extends Equatable {
  final List<MutualFund>? fundList;

  const GetFundBySubcategoryState({
    this.fundList,
  });
}

class GetFundBySubcategoryInitial extends GetFundBySubcategoryState {
  const GetFundBySubcategoryInitial();

  @override
  List<Object> get props => [];
}

class GetFundBySubcategoryLoading extends GetFundBySubcategoryState {
  final List<MutualFund> oldFundList;

  const GetFundBySubcategoryLoading({
    required this.oldFundList,
  }) : super(fundList: oldFundList);

  @override
  List<Object> get props => [oldFundList];
}

class GetFundBySubcategoryLoaded extends GetFundBySubcategoryState {
  final List<MutualFund> newFundList;
  final bool isLastPage;
  const GetFundBySubcategoryLoaded({
    required this.newFundList,
    required this.isLastPage,
  }) : super(fundList: newFundList);

  @override
  List<Object> get props => [newFundList, isLastPage];
}

class GetFundBySubcategoryLoadError extends GetFundBySubcategoryState {
  final List<MutualFund> oldFundList;
  final String? error;
  final AppErrorType errorType;

  const GetFundBySubcategoryLoadError({
    required this.oldFundList,
    required this.error,
    required this.errorType,
  }) : super(fundList: oldFundList);

  @override
  List<Object> get props => [oldFundList, error ?? '', errorType];
}
