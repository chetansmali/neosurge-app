import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/mutual_funds/fund.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/mutual_funds/get_switch_funds_params.dart';
import '../../../../domain/usecases/assisted_service/get_assisted_switch_funds.dart';
import '../../../../domain/usecases/mutual_funds/get_switch_funds.dart';

part 'switch_funds_list_state.dart';

@injectable
class SwitchFundsListCubit extends Cubit<SwitchFundsListState> {
  final GetSwitchFunds _getSwitchFunds;
  final GetAssistedSwitchFunds _getAssistedSwitchFunds;

  SwitchFundsListCubit(this._getSwitchFunds, this._getAssistedSwitchFunds)
      : super(SwitchFundsListInitial());

  List<Fund> _funds = [];

  void getSwitchFunds({
    required String schemeCode,
    required double switchAmount,
    required String amcCode,
    bool isAssisted = false,
  }) async {
    emit(SwitchFundsListLoading());
    final result = isAssisted
        ? await _getAssistedSwitchFunds(GetSwitchFundsParams(
            schemeCode: schemeCode,
            switchAmount: switchAmount,
            amcCode: amcCode,
          ))
        : await _getSwitchFunds(GetSwitchFundsParams(
            schemeCode: schemeCode,
            switchAmount: switchAmount,
            amcCode: amcCode,
          ));
    if (isClosed) return;

    result.fold(
      (l) => emit(SwitchFundsListError(l.errorType, l.error)),
      (r) {
        r.sort((a, b) => b.performance.threeY.compareTo(a.performance.threeY));
        _funds = r;
        emit(SwitchFundsListLoaded(r));
      },
    );
  }

  void searchFunds(String query) {
    if (query.isEmpty) {
      emit(SwitchFundsListLoaded(_funds));
    } else {
      final filteredFunds = _funds
          .where((fund) =>
              fund.schemeNameUnique.toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(SwitchFundsListLoaded(filteredFunds));
    }
  }
}
