import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../data/models/equity/equity_explore/all_stocks.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/equity/equity_explore/all_stocks_params.dart';
import '../../../../domain/usecases/equity/get_all_stocks.dart';

part 'all_stocks_state.dart';

@injectable
class AllStocksCubit extends Cubit<AllStocksState> {
  GetStocksList getStocksList;

  int _page = 0; //Used for pagination

  AllStocksCubit(this.getStocksList) : super(AllStocksInitial());

  Future<void> fetchStocks({
    String? direction,
    bool isInitialLoading = false,
    int? page,
    int size = 20,
    String? filter,
    String? sortBy,
    String? sectors,
  }) async {
    if (state is AllStocksLoading) return;

    List<AllStocksModel> oldStocksList = [];

    if (page == null) {
      final currentState = state;

      if (currentState is AllStocksLoaded) {
        oldStocksList = currentState.allStocksModel;
      } else if (currentState is AllStocksFailure) {
        oldStocksList = currentState.allStocksModel;
      }
    } else {
      _page = page;
    }

    emit(
      AllStocksLoading(
        oldStocksList: oldStocksList,
        isInitialLoading: _page == 0,
      ),
    );

    final response = await getStocksList(
      AllStocksParams(
        direction: direction,
        page: _page.toString(),
        size: size.toString(),
        filter: ((filter ?? '').isEmpty) ? null : filter,
        sortBy: sortBy,
        industries: sectors,
      ),
    );

    if (isClosed) return;

    response.fold(
      (l) => emit(
        AllStocksFailure(
          allStocksModel: oldStocksList,
          errorType: l.errorType,
          errorMessage: l.error,
          isInitialLoading: isInitialLoading,
        ),
      ),
      (r) {
        List<AllStocksModel> newFunds = r;
        if (newFunds.isEmpty) {
          emit(AllStocksLoaded(List.empty(growable: true), true));
        } else {
          _page = _page + 1;
          oldStocksList.addAll(newFunds);
          emit(
            AllStocksLoaded(
              oldStocksList,
              newFunds.length < size,
            ),
          );
        }
      },
    );
  }
}
