import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/mutual_funds/user_mf_holding.dart';
import '../../../../data/models/mutual_funds/user_mf_scheme.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/user_id_param.dart';
import '../../../../domain/usecases/assisted_service/get_assisted_holdings.dart';

part 'assisted_holdings_state.dart';

@injectable
class AssistedHoldingsCubit extends Cubit<AssistedHoldingsState> {
  final GetAssistedHoldings _getAssistedHoldings;

  AssistedHoldingsCubit(this._getAssistedHoldings) : super(AssistedHoldingsInitial());

  Future<void> getAssistedHoldings({required int userId}) async {
    if (state is AssistedHoldingsLoading) return;
    emit(AssistedHoldingsLoading());
    final res = await _getAssistedHoldings(UserIdParam(userId: userId));
    emit(res.fold((l) => AssistedHoldingsError(l.errorType, l.error), (r) {
      if (r == null) return AssistedHoldingsLoaded(r);
      //copyWith holdings with isAssisted=true
      // We set it to true so that its easier to pass this value in redeem and switch fund screen
      List<UserMfScheme> holdings = r.schemes.map((e) => e.copyWith(isAssistedFund: true)).toList();
      return AssistedHoldingsLoaded(r.copyWith(schemes: holdings));
    }));
    return;
  }

  Future<void> refreshAssistedHoldings({required int userId}) async {
    if (state is AssistedHoldingsLoaded) {
      final holdings = (state as AssistedHoldingsLoaded).userMfHoldings;
      final res = await _getAssistedHoldings(UserIdParam(userId: userId));
      emit(res.fold((l) => AssistedHoldingsLoaded(holdings), (r) {
        if (r == null) return AssistedHoldingsLoaded(r);
        //copyWith holdings with isAssisted=true
        // We set it to true so that its easier to pass this value in redeem and switch fund screen
        List<UserMfScheme> holdings = r.schemes.map((e) => e.copyWith(isAssistedFund: true)).toList();

        return AssistedHoldingsLoaded(r.copyWith(schemes: holdings));
      }));
    } else {
      await getAssistedHoldings(userId: userId);
    }
    return;
  }
}
