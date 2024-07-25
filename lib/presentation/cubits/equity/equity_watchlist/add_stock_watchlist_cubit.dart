import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/equity/equity_watchllist/add_stock_watchlist_model.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/equity/equity_watchlist/add_stock_watchlist.dart';
import '../../../../domain/usecases/equity/add_stock_watchlist.dart';

part 'add_stock_watchlist_state.dart';

@injectable
class AddStockWatchlistCubit extends Cubit<AddStockWatchlistState> {
  final PutStockToWatchlist putStockToWatchlist;

  AddStockWatchlistCubit(this.putStockToWatchlist)
      : super(AddStockWatchlistInitial());

  Future pushStockWatchlist(AddStockWatchlistParams params) async {
    emit(AddStockWatchlistLoading());
    final response = await putStockToWatchlist(params);
    response.fold(
        (l) => emit(AddStockWatchlistFailure(
            errorType: l.errorType, errorMessage: l.error)),
        (r) => emit(AddStockWatchlistLoaded(addStockWatchModel: r)));
  }
}
