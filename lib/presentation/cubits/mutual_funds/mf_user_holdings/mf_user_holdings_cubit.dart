import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/mutual_funds/user_mf_holding.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/user_id_param.dart';
import '../../../../domain/usecases/mutual_funds/get_user_mf_holdings.dart';

part 'mf_user_holdings_state.dart';

@injectable
class MfUserHoldingsCubit extends Cubit<MfUserHoldingsState> {
  final GetUserMFHoldings _getUserMFHoldings;

  MfUserHoldingsCubit(this._getUserMFHoldings) : super(MfUserHoldingsInitial());

  Future<void> getUserHoldings({required int userId}) async {
    if (state is MfUserHoldingsLoading) return;
    emit(MfUserHoldingsLoading());
    final res = await _getUserMFHoldings(UserIdParam(userId: userId));
    emit(res.fold((l) => MfUserHoldingsError(l.errorType, l.error), (r) => MfUserHoldingsLoaded(r)));
    return;
  }

  Future<void> refreshUserHoldings({required int userId}) async {
    if (state is MfUserHoldingsLoaded) {
      final holdings = (state as MfUserHoldingsLoaded).userMfHoldings;
      final res = await _getUserMFHoldings(UserIdParam(userId: userId));
      emit(res.fold((l) => MfUserHoldingsLoaded(holdings), (r) => MfUserHoldingsLoaded(r)));
    } else {
      await getUserHoldings(userId: userId);
    }
    return;
  }
}
