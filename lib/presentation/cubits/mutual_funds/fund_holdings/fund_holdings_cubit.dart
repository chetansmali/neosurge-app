import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/mutual_funds/fund_holding.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/mutual_funds/get_mutual_fund_holdings_params.dart';
import '../../../../domain/usecases/mutual_funds/get_fund_holdings.dart';

part 'fund_holdings_state.dart';

@injectable
class FundHoldingsCubit extends Cubit<FundHoldingsState> {
  final GetFundHoldings _getFundHoldings;

  FundHoldingsCubit(this._getFundHoldings) : super(FundHoldingsInitial());

  void getHoldings({required String schemeCode}) async {
    emit(FundHoldingsLoading());

    final result = await _getFundHoldings(GetMutualFundHoldingParams(schemeCode: schemeCode));

    result.fold(
      (l) => emit(FundHoldingsLoadError(appErrorType: l.errorType, errorMessage: l.error)),
      (r) => emit(FundHoldingsLoaded(holdings: r)),
    );
  }
}
