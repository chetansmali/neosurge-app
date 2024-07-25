import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/equity/equity_watchllist/create_watchlist_model.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/equity/equity_watchlist/create_watchlist_params.dart';
import '../../../../domain/usecases/equity/get_create_watchlist.dart';

part 'create_watchlist_state.dart';

@injectable
class CreateWatchlistCubit extends Cubit<CreateWatchlistState> {
  final GetCreateWatchlist getCreateWatchlist;

  CreateWatchlistCubit(this.getCreateWatchlist)
      : super(CreateWatchlistInitial());

  Future createWatchlist(CreateWatchlistParams params) async {
    emit(CreateWatchlistLoading());
    final response = await getCreateWatchlist(params);
    response.fold(
        (l) => emit(CreateWatchlistFailure(
            errorType: l.errorType, errorMessage: l.error)),
        (r) => emit(CreateWatchlistLoaded(r)));
  }
}
