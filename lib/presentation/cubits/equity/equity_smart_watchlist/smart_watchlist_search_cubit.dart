import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/equity/equity_smart_watchlist/smart_watchlist_search_model.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/equity/equity_smart_watchlist/smart_watchlist_search_params.dart';
import '../../../../domain/usecases/equity/get_smart_watchlist_search.dart';

part 'smart_watchlist_search_state.dart';

@injectable
class SmartWatchlistSearchCubit extends Cubit<SmartWatchlistSearchState> {
  final GetSmartWatchlistSearch _getSmartWatchlistSearch;
  String? _searchText;
  SmartWatchlistSearchCubit(this._getSmartWatchlistSearch)
      : super(SmartWatchlistSearchInitial());

  final int _fundFetchLimit = 20;

  void getMutualFundsWithQuery(
    String query, {
    int? offset,
  }) async {
    if ((_searchText?.trim() == query.trim() || query.trim().length < 3) &&
        offset == 0) {
      return;
    }

    if (state is SmartWatchlistSearchLoading) return;

    List<SmartWatchlistSearchModel> oldFunds = [];
    if (offset == null) {
      final currentState = state;

      if (currentState is SmartWatchlistSearchLoaded) {
        oldFunds = currentState.funds;
      } else if (currentState is SmartWatchlistSearchLoadError) {
        oldFunds = currentState.oldFunds;
      }
    }

    _searchText = query;

    emit(SmartWatchlistSearchLoading(
      oldFunds: oldFunds,
      isFirstFetch: true, //_offset == 0,
    ));

    final response = await _getSmartWatchlistSearch(
      SmartWatchlistSearchParams(filter: query, size: _fundFetchLimit),
    );

    response.fold(
      (l) => SmartWatchlistSearchLoadError(
        oldFunds: oldFunds,
        appErrorType: l.errorType,
        errorMessage: l.error,
      ),
      (r) {
        List<SmartWatchlistSearchModel> newFunds = r;
        if (newFunds.isEmpty) {
          emit(
            SmartWatchlistSearchLoaded(funds: oldFunds, isLastPage: true),
          );
        } else {
          // _offset += _fundFetchLimit;
          oldFunds.addAll(newFunds);

          emit(
            SmartWatchlistSearchLoaded(
              funds: oldFunds,
              isLastPage: newFunds.length < _fundFetchLimit,
            ),
          );
        }
      },
    );
  }

  void resetSearch() {
    _searchText = null;
    emit(SmartWatchlistSearchInitial());
  }
}
