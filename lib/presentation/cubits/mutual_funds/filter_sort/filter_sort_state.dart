part of 'filter_sort_cubit.dart';

abstract class FilterSortState extends Equatable {
  final List<String> amcs;
  final List<String> assetCategories;
  final List<String> assetSubCategories;
  final List<int> selectedRating;
  final List<String> selectedRisks;

  const FilterSortState({required this.amcs, required this.assetCategories, required this.assetSubCategories, required this.selectedRating, required this.selectedRisks});

  @override
  List<Object> get props => [amcs, assetCategories, assetSubCategories, selectedRating, selectedRisks];
}

class FilterSortLoaded extends FilterSortState {
  const FilterSortLoaded(
      {required List<String> amcs, required List<String> assetCategories, required List<String> assetSubCategories, required List<int> selectedRating, required List<String> selectedRisks})
      : super(amcs: amcs, assetCategories: assetCategories, assetSubCategories: assetSubCategories, selectedRating: selectedRating, selectedRisks: selectedRisks);
}
