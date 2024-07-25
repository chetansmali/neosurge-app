import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/mutual_funds/fund.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/mutual_funds/get_mutual_funds_params.dart';
import '../../../../domain/usecases/mutual_funds/get_mutual_funds.dart';

part 'get_fund_state.dart';

@injectable
class GetFundCubit extends Cubit<GetFundState> {
  final GetMutualFunds _getMutualFunds;

  GetFundCubit(
    this._getMutualFunds,
  ) : super(GetFundInitial());

  void getFundBySchemeCode({
    required String schemeCode,
  }) async {
    emit(GetFundLoading());
    final res = await _getMutualFunds(GetMutualFundsParams(
      from: 0,
      size: 1,
      schemeCode: schemeCode,
    ));
    if (isClosed) return;
    emit(
      res.fold(
        (l) => GetFundLoadFailure(errorType: l.errorType, error: l.error),
        (r) => GetFundLoaded(fund: r.first),
      ),
    );
  }
}
