import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/equity/etf_stocks.dart';
import '../../../domain/entities/app_error.dart';
import '../../../domain/entities/params/equity/etf_stocks.dart';
import '../../../domain/usecases/equity/get_etfs.dart';

part 'etf_stocks_state.dart';

@injectable
class EtfStocksCubit extends Cubit<EtfStocksState> {
  GetETFList getETFList;

  int _page = 0; //Used for pagination

  EtfStocksCubit(this.getETFList) : super(EtfStocksInitial());

  Future fetchETFs({
    bool isInitialLoading = false,
    int? page,
    int size = 20,
    String? filter,
    String? sort,
  }) async {
    if (state is EtfStocksLoading) return;

    List<ETFStocksModel> oldETFsList = [];

    if (page == null) {
      final currentState = state;

      if (currentState is EtfStocksLoaded) {
        oldETFsList = currentState.etfStocksModel;
      } else if (currentState is EtfStocksFailure) {
        oldETFsList = currentState.allStocksModel;
      }
    } else {
      _page = page;
    }

    emit(
      EtfStocksLoading(
        oldStocksList: oldETFsList,
        isInitialLoading: _page == 0,
      ),
    );

    final response = await getETFList(
      ETFStocksParams(
        page: _page.toString(),
        size: size.toString(),
        filter: ((filter ?? '').isEmpty) ? null : filter,
        sort: sort ?? 'close,DESC',
      ),
    );

    if (isClosed) return;

    response.fold(
      (l) => emit(
        EtfStocksFailure(
          allStocksModel: oldETFsList,
          errorType: l.errorType,
          errorMessage: l.error,
          isInitialLoading: isInitialLoading,
        ),
      ),
      (r) {
        List<ETFStocksModel> newFunds = r;
        if (newFunds.isEmpty) {
          emit(EtfStocksLoaded(List.empty(growable: true), true));
        } else {
          _page = _page + 1;
          oldETFsList.addAll(newFunds);
          emit(
            EtfStocksLoaded(
              oldETFsList,
              newFunds.length < size,
            ),
          );
        }
      },
    );
  }
}
