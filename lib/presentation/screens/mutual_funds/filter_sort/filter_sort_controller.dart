import 'package:flutter/cupertino.dart';

import '../../../../constants/filter_sort_values.dart';
import '../../../cubits/mutual_funds/filter_sort/filter_sort_cubit.dart';

class FilterSortController extends ChangeNotifier {
  FilterSortController({required FilterSortState state}) {
    _state = state;
    _checkIfApplied();
  }

  int _selectedFilterIndex = 0;
  late final FilterSortState _state;
  final List<String> _appliedAmc = [];
  final List<String> _appliedAssetCategories = [];
  final List<String> _appliedAssetSubCategories = [];
  final List<int> _appliedRating = [];
  final List<String> _appliedRisks = [];

  int get selectedFilterIndex => _selectedFilterIndex;

  List<String> get appliedAmc => _appliedAmc;

  List<String> get appliedAssetCategories => _appliedAssetCategories;

  List<String> get appliedAssetSubCategories => _appliedAssetSubCategories;

  List<int> get appliedRating => _appliedRating;

  List<String> get appliedRisks => _appliedRisks;

  bool get isFiltersEmpty => _appliedAmc.isEmpty && _appliedAssetCategories.isEmpty && _appliedAssetSubCategories.isEmpty && _appliedRating.isEmpty && _appliedRisks.isEmpty;

  void _checkIfApplied() {
    _appliedAmc.addAll(_state.amcs);
    _appliedAssetCategories.addAll(_state.assetCategories);
    _appliedAssetSubCategories.addAll(_state.assetSubCategories);
    _appliedRating.addAll(_state.selectedRating);
    _appliedRisks.addAll(_state.selectedRisks);
  }

  void setSelectedFilterIndex(int index) {
    _selectedFilterIndex = index;
    notifyListeners();
  }

  void _toggleAppliedAssetCategory(String assetCategory) {
    if (_appliedAssetCategories.contains(assetCategory)) {
      _appliedAssetCategories.remove(assetCategory);
    } else {
      _appliedAssetCategories.add(assetCategory);
    }
    notifyListeners();
  }

  void _toggleAppliedAssetSubCategory(String assetSubCategory) {
    if (_appliedAssetSubCategories.contains(assetSubCategory)) {
      _appliedAssetSubCategories.remove(assetSubCategory);
    } else {
      _appliedAssetSubCategories.add(assetSubCategory);
    }
    notifyListeners();
  }

  void _toggleAppliedAmc(String amc) {
    if (_appliedAmc.contains(amc)) {
      _appliedAmc.remove(amc);
    } else {
      _appliedAmc.add(amc);
    }
    notifyListeners();
  }

  void _toggleSelectedRating(int rating) {
    if (_appliedRating.contains(rating)) {
      _appliedRating.remove(rating);
    } else {
      _appliedRating.add(rating);
    }
  }

  void _toggleAppliedRisks(String risk) {
    if (_appliedRisks.contains(risk)) {
      _appliedRisks.remove(risk);
    } else {
      _appliedRisks.add(risk);
    }
    notifyListeners();
  }

  void handleOnTap(int index) {
    final String value = _getStringValue(_selectedFilterIndex, index);
    switch (_selectedFilterIndex) {
      case 0:
        _toggleAppliedAmc(value);
        break;
      case 1:
        _toggleAppliedAssetCategory(value);
        break;
      case 2:
        _toggleAppliedAssetSubCategory(value);
        break;
      case 3:
        _toggleSelectedRating(index + 1);
        break;
      case 4:
        _toggleAppliedRisks(value);
        break;
    }
    notifyListeners();
  }

  String _getStringValue(int filterIndex, int index) {
    switch (filterIndex) {
      case 0:
        return FilterSortValues.amcNameList[index];
      case 1:
        return FilterSortValues.assetCategories[index];
      case 2:
        return FilterSortValues.assetSubCategories[index];
      case 4:
        return FilterSortValues.riskList[index];
      default:
        return "";
    }
  }

  List<String> get getSelectedFilterValue {
    switch (_selectedFilterIndex) {
      case 0:
        return FilterSortValues.amcNameList;
      case 1:
        return FilterSortValues.assetCategories;
      case 2:
        return FilterSortValues.assetSubCategories;
      case 3:
        return ['1', '2', '3', '4', '5'];
      case 4:
        return FilterSortValues.riskList;
      default:
        return [];
    }
  }

  int getAppliedFilterValueCount(index) {
    switch (index) {
      case 0:
        return _appliedAmc.length;
      case 1:
        return _appliedAssetCategories.length;
      case 2:
        return _appliedAssetSubCategories.length;
      case 3:
        return _appliedRating.length;
      case 4:
        return _appliedRisks.length;
      default:
        return 0;
    }
  }

  bool isFilterSelected(int index) {
    switch (_selectedFilterIndex) {
      case 0:
        return _appliedAmc.contains(FilterSortValues.amcNameList[index]);
      case 1:
        return _appliedAssetCategories.contains(FilterSortValues.assetCategories[index]);
      case 2:
        return _appliedAssetSubCategories.contains(FilterSortValues.assetSubCategories[index]);
      case 3:
        return _appliedRating.contains((index + 1));
      case 4:
        return _appliedRisks.contains(FilterSortValues.riskList[index]);
      default:
        return false;
    }
  }

  void resetFilter() {
    _appliedAmc.clear();
    _appliedAssetCategories.clear();
    _appliedAssetSubCategories.clear();
    _appliedRating.clear();
    _appliedRisks.clear();
    notifyListeners();
  }
}
