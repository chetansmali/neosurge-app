
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/mutual_funds/fund.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/mutual_funds/get_mutual_funds_params.dart';
import '../../../../domain/usecases/mutual_funds/get_mutual_funds.dart';

part 'search_fund_state.dart';

@injectable
class SearchFundCubit extends Cubit<SearchFundState> {
  final GetMutualFunds _getMutualFunds;
  String? _searchText;

  SearchFundCubit(this._getMutualFunds) : super(SearchFundInitial());

  int _offset = 0; //Used for pagination
  final int _fundFetchLimit = 20; //20 funds are being fetched every time

  void getMutualFundsWithQuery(
    String query, {
    int? offset,
  }) async {
    if ((_searchText?.trim() == query.trim() || query.trim().length < 3) &&
        offset == 0) {
      return;
    }

    if (state is SearchFundLoading) return;

    List<Fund> oldFunds = [];
    if (offset == null) {
      final currentState = state;

      if (currentState is SearchFundLoaded) {
        oldFunds = currentState.funds;
      } else if (currentState is SearchFundLoadError) {
        oldFunds = currentState.oldFunds;
      }
    } else {
      _offset = offset;
    }

    _searchText = query;

    emit(SearchFundLoading(
      oldFunds: oldFunds,
      isFirstFetch: _offset == 0,
    ));

    final response = await _getMutualFunds(
      GetMutualFundsParams(
        from: _offset,
        size: _fundFetchLimit,
        searchText: query,
        holdingPeriod: '',
      ),
    );

    response.fold(
      (l) => SearchFundLoadError(
        oldFunds: oldFunds,
        appErrorType: l.errorType,
        errorMessage: l.error,
      ),
      (r) {
        List<Fund> newFunds = r;
        if (newFunds.isEmpty) {
          emit(
            SearchFundLoaded(funds: oldFunds, isLastPage: true),
          );
        } else {
          _offset += _fundFetchLimit;
          oldFunds.addAll(newFunds);

          emit(
            SearchFundLoaded(
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
    _offset = 0;
    emit(SearchFundInitial());
  }
}
