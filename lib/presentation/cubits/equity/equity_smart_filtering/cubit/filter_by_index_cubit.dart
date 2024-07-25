import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../data/models/equity/smart_filtering/stocks_by_index_model.dart';
import '../../../../../data/models/equity/smart_filtering/subsidiaries_model.dart';
import '../../../../../domain/entities/app_error.dart';
import '../../../../../domain/entities/params/equity/filter_by_index_params.dart';
import '../../../../../domain/usecases/equity/get_stocks_by_index.dart';

part 'filter_by_index_state.dart';

@injectable
class FilterByIndexCubit extends Cubit<FilterByIndexState> {
  final GetStocksByIndex _getStocksByIndex;

  int _page = 0;

  FilterByIndexCubit(this._getStocksByIndex) : super(FilterByIndexInitial());

  void filterByIndex({
    required String index,
    bool isInitialLoading = false,
    int? page,
    int size = 20,
    String? sort,
    String? filter,
  }) async {
    if (state is FilterByIndexLoading) return;

    List<SubsidiaryModel> oldETFsList = [];

    if (page == null) {
      final currentState = state;

      if (currentState is FilterByIndexSuccess) {
        oldETFsList = currentState.stocksByIndex.indexInstruments;
      } else if (currentState is FilterByIndexFailure) {
        oldETFsList = currentState.allStocksModel;
      }
    } else {
      _page = page;
    }

    emit(
      FilterByIndexLoading(
        oldStocksList: oldETFsList,
        isInitialLoading: _page == 0,
      ),
    );

    final response = await _getStocksByIndex(
      FilterByIndexParams(
        index: index,
        page: _page,
        size: size,
        sort: sort ?? 'marketCapitalization,DESC',
        filter: ((filter ?? '').isEmpty) ? null : filter,
      ),
    );

    if (isClosed) return;

    response.fold(
      (l) => emit(
        FilterByIndexFailure(
          allStocksModel: oldETFsList,
          errorType: l.errorType,
          errorMessage: l.error,
          isInitialLoading: isInitialLoading,
        ),
      ),
      (r) {
        List<SubsidiaryModel> newFunds = r.indexInstruments;
        if (newFunds.isEmpty) {
          emit(FilterByIndexSuccess(
            stocksByIndex: StocksByIndexModel(
                indexInstruments: List.empty(growable: true), index: r.index),
            isLastPage: true,
          ));
        } else {
          _page = _page + 1;
          oldETFsList.addAll(newFunds);
          emit(
            FilterByIndexSuccess(
              stocksByIndex: StocksByIndexModel(
                  indexInstruments: oldETFsList, index: r.index),
              isLastPage: newFunds.length < size,
            ),
          );
        }
      },
    );
  }
}
