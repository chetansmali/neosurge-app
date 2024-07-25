import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/equity/equity_watchllist/delete_watchlist.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/equity/equity_watchlist/delete_watchlist_params.dart';
import '../../../../domain/usecases/equity/remove_watchlist.dart';

part 'remove_watchlist_state.dart';

@injectable
class RemoveWatchlistCubit extends Cubit<RemoveWatchlistState> {
  final RemoveWatchlist removeWatchlist;

  RemoveWatchlistCubit(this.removeWatchlist) : super(RemoveWatchlistInitial());

  Future deleteWatchlist(DeleteWatchlistParams params) async {
    emit(RemoveWatchlistLoading());
    final response = await removeWatchlist(params);
    response.fold((l) => emit(RemoveWatchlistFailure(l.errorType, l.error)),
        (r) => emit(RemoveWatchlistSuccess(r)));
  }
}
