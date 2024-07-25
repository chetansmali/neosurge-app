import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'filter_sort_state.dart';

@injectable
class FilterSortCubit extends Cubit<FilterSortState> {
  FilterSortCubit() : super(const FilterSortLoaded(amcs: [], assetCategories: [], assetSubCategories: [], selectedRating: [], selectedRisks: []));

  void applyFilter(
      {required List<String> appliedAmc,
      required List<String> appliedAssetCategories,
      required List<String> appliedAssetSubCategories,
      required List<int> selectedRating,
      required List<String> selectedRisks}) {
    emit(FilterSortLoaded(
      amcs: appliedAmc,
      assetCategories: appliedAssetCategories,
      assetSubCategories: appliedAssetSubCategories,
      selectedRating: selectedRating,
      selectedRisks: selectedRisks,
    ));
  }

  bool get isFiltersEmpty => state.amcs.isEmpty && state.assetCategories.isEmpty && state.assetSubCategories.isEmpty && state.selectedRating.isEmpty && state.selectedRisks.isEmpty;
}
