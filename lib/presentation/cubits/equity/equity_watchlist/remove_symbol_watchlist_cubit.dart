import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/equity/equity_watchllist/delete_symbol.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/equity/equity_watchlist/delete_symbol.dart';
import '../../../../domain/usecases/equity/remove_watchlist_symbol.dart';

part 'remove_symbol_watchlist_state.dart';

@injectable
class RemoveSymbolWatchlistCubit extends Cubit<RemoveSymbolWatchlistState> {
  final RemoveWatchlistSymbol removeWatchlistSymbol;
  RemoveSymbolWatchlistCubit(this.removeWatchlistSymbol)
      : super(RemoveSymbolWatchlistInitial());

  Future earseSymbol(int watchlistID, int symbolID) async {
    emit(RemoveSymbolWatchlistLoading());
    final response = await removeWatchlistSymbol(
        DeleteSymbolParams(watchlistId: watchlistID, symbolId: symbolID));
    response.fold(
        (l) => emit(RemoveSymbolWatchlistFailure(l.errorType, l.error)),
        (r) => emit(RemoveSymbolWatchlistSuccess(deleteSymbolModel: r)));
  }
}
