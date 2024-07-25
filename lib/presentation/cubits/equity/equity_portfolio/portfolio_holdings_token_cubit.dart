import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/equity/equity_portfolio/get_smallcase_fund.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/equity/equity_portfolio/get_holdings_token_params.dart';
import '../../../../domain/usecases/equity/get_equity_holdings_token.dart';

part 'portfolio_holdings_token_state.dart';

@injectable
class PortfolioHoldingsTokenCubit extends Cubit<PortfolioHoldingsTokenState> {
  final GetEquityHoldingsToken _equityHoldingsToken;

  PortfolioHoldingsTokenCubit(this._equityHoldingsToken)
      : super(PortfolioHoldingsTokenInitial());

  Future fetchHoldingsToken(EquityHoldingsTokenParams params) async {
    emit(PortfolioHoldingsTokenLoading());
    final response = await _equityHoldingsToken(params);
    response.fold(
      (l) => emit(PortfolioHoldingsTokenFailure(
          errorType: l.errorType, errorMessage: l.error)),
      (r) => emit(PortfolioHoldingsTokenLoaded(r)),
    );
  }
}
