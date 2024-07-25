part of 'filter_by_sector_industry_cubit.dart';

abstract class FilterBySectorIndustryState extends Equatable {
  const FilterBySectorIndustryState();
}

class FilterBySectorIndustryInitial extends FilterBySectorIndustryState {
  @override
  List<Object> get props => [];
}

class FilterBySectorIndustryLoading extends FilterBySectorIndustryState {
  @override
  List<Object> get props => [];
}

class FilterBySectorIndustrySuccess extends FilterBySectorIndustryState {
  final FilterBySectorIndustryDetails filterBySectorIndustryDetails;
  const FilterBySectorIndustrySuccess(this.filterBySectorIndustryDetails);
  @override
  List<Object> get props => [filterBySectorIndustryDetails];
}

class FilterBySectorIndustryFailure extends FilterBySectorIndustryState {
  final String? errorMessage;
  final AppErrorType errorType;

  const FilterBySectorIndustryFailure(this.errorMessage, this.errorType);
  @override
  List<Object?> get props => [errorMessage, errorType];
}
