import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/equity/equity_smart_watchlist/smart_watchlist_holdings.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/equity/get_smart_watchlist_holdings.dart';

part 'smart_watchlist_holdings_state.dart';

@injectable
class SmartWatchlistHoldingsCubit extends Cubit<SmartWatchlistHoldingsState> {
  final GetSmartWatchlistHoldings getSmartWatchlistHoldings;
  SmartWatchlistHoldingsCubit(this.getSmartWatchlistHoldings)
      : super(SmartWatchlistHoldingsInitial());

  Future fetchHoldings() async {
    emit(SmartWatchlistHoldingsLoading());

    final response = await getSmartWatchlistHoldings(NoParams());
    response.fold(
      (l) => emit(SmartWatchlistHoldingsFailure(
          errorType: l.errorType, errorMessage: l.error)),
      (r) => emit(
        SmartWatchlistHoldingsLoaded(r),
      ),
    );
  }
}
