import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/equity/equity_watchllist/get_all_watchlist_model.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/equity/get_all_watchlist.dart';

part 'get_all_user_watchlis_state.dart';

@injectable
class GetAllUserWatchlisCubit extends Cubit<GetAllUserWatchlisState> {
  final GetUserAllWatchlist getUserAllWatchlist;

  GetAllUserWatchlisCubit(this.getUserAllWatchlist)
      : super(GetAllUserWatchlisInitial());

  Future fetchAllWatchlist() async {
    emit(GetAllUserWatchlisLoading());
    final response = await getUserAllWatchlist(NoParams());
    response.fold((l) => emit(GetAllUserWatchlistFailure(l.errorType, l.error)),
        (r) {
      emit(GetAllUserWatchlisLoaded(getAllWatchlist: r));
    });
  }
}
