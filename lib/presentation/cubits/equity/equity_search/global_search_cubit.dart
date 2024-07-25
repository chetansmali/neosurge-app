import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/equity/equity_search/global_search_model.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/equity/equity_search/global_search_params.dart';
import '../../../../domain/usecases/equity/get_gobal_search.dart';

part 'global_search_state.dart';

@injectable
class GlobalSearchCubit extends Cubit<GlobalSearchState> {
  final GetGobalSearch getGobalSearch;
  String? _searchText;

  GlobalSearchCubit(this.getGobalSearch) : super(GlobalSearchInitial());

  void getEquityGlobalSearchQuery(
    String query, {
    int? offset,
  }) async {
    if ((_searchText?.trim() == query.trim() || query.trim().length < 3) &&
        offset == 0) {
      return;
    }

    if (state is GlobalSearchLoaded) return;

    List<GlobalSearchModel> oldStocks = [];
    if (offset == null) {
      final currentState = state;

      if (currentState is GlobalSearchLoaded) {
        oldStocks = currentState.stock;
      } else if (currentState is GlobalSearchLoadError) {
        oldStocks = currentState.oldStocks;
      }
    }
    _searchText = query;
    emit(GlobalSearchLoading(oldStocks: oldStocks));

    final response = await getGobalSearch(
      GlobalSearchParams(symbol: query),
    );

    response.fold(
        (l) => GlobalSearchLoadError(
            oldStocks: oldStocks,
            appErrorType: l.errorType,
            errorMessage: l.error), (r) {
      List<GlobalSearchModel> newStocks = r;
      if (newStocks.isEmpty) {
        emit(GlobalSearchLoaded(stock: oldStocks));
      } else {
        oldStocks.addAll(newStocks);
        emit(GlobalSearchLoaded(stock: oldStocks));
      }
    });
  }

  void restSearch() {
    _searchText = null;
    emit(GlobalSearchInitial());
  }
}
