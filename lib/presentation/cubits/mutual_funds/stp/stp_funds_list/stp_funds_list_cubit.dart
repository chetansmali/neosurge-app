import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../data/models/mutual_funds/fund.dart';
import '../../../../../domain/entities/app_error.dart';
import '../../../../../domain/entities/params/mutual_funds/get_stp_funds_params.dart';
import '../../../../../domain/usecases/mutual_funds/get_stp_funds.dart';

part 'stp_funds_list_state.dart';

@injectable
class StpFundsListCubit extends Cubit<StpFundsListState> {
  final GetStpFunds _getStpFunds;

  StpFundsListCubit(this._getStpFunds) : super(StpFundsListInitial());

  List<Fund> _funds = [];

  void getStpFunds({
    required String schemeCode,
    required double stpAmount,
    required String amcCode,
  }) async {
    emit(StpFundsListLoading());
    final result = await _getStpFunds(
      GetStpFundsParams(
        amcCode: amcCode,
        schemeCode: schemeCode,
        stpAmount: stpAmount,
      ),
    );
    if (isClosed) return;
    result.fold(
      (l) => emit(StpFundsListError(l.errorType, l.error)),
      (r) {
        r.sort((a, b) => b.performance.threeY.compareTo(a.performance.threeY));
        _funds = r;
        emit(StpFundsListLoaded(r));
      },
    );
  }

  void searchFunds(String query) {
    if (query.isEmpty) {
      emit(StpFundsListLoaded(_funds));
    } else {
      final filteredFunds = _funds
          .where(
            (fund) => fund.schemeNameUnique.toLowerCase().contains(
                  query.toLowerCase(),
                ),
          )
          .toList();

      emit(StpFundsListLoaded(filteredFunds));
    }
  }
}
