import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/equity/equity_watchllist/get_watchlist_stock.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/equity/equity_watchlist/get_watchlist_symbol.dart';
import '../../../../domain/usecases/equity/get_watchlist_symbol.dart';

part 'watchlist_symbol_state.dart';

@injectable
class WatchlistSymbolCubit extends Cubit<WatchlistSymbolState> {
  final GetWatchlistSymbol getWatchlistSymbol;
  WatchlistSymbolCubit(this.getWatchlistSymbol)
      : super(WatchlistSymbolInitial());

  Future fetchWatchlistSymbol(GetWatchlistSymbolParams params) async {
    emit(WatchlistSymbolLoading());
    final response = await getWatchlistSymbol(params);
    response.fold(
      (l) => emit(
        WatchlistSymbolFailure(
          l.errorType,
          l.error,
          int.parse(params.id),
        ),
      ),
      (r) {
        emit(WatchlistSymbolLoaded(r));
      },
    );
  }

  void reset() {
    emit(WatchlistSymbolInitial());
  }
}
