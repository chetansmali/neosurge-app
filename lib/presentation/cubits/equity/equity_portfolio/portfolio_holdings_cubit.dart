import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/equity/equity_portfolio/portfolio_holdings.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/equity/equity_orders/equity_holding_position_params.dart';
import '../../../../domain/usecases/equity/get_holdings.dart';

part 'portfolio_holdings_state.dart';

@injectable
class PortfolioHoldingsCubit extends Cubit<PortfolioHoldingsState> {
  final GetEquityholdings getEquityholdings;

  PortfolioHoldingsCubit(this.getEquityholdings)
      : super(PortfolioHoldingsInitial());

  Future fetchHoldings() async {
    emit(PortfolioHoldingsLoading());
    final response = await getEquityholdings(
        EquityHoldingPortfolioParams(instrumentType: 'EQUITY'));
    response.fold(
        (l) => emit(PortfolioHoldingsFailure(
            errorType: l.errorType, errorMessage: l.error)),
        (r) => emit(PortfolioHoldingsLoaded(r)));
  }

  Future fetchETFHoldings() async {
    emit(PortfolioHoldingsLoading());
    final response = await getEquityholdings(
        EquityHoldingPortfolioParams(instrumentType: 'ETF'));
    response.fold(
        (l) => emit(PortfolioHoldingsFailure(
            errorType: l.errorType, errorMessage: l.error)),
        (r) => emit(PortfolioHoldingsLoaded(r)));
  }
}
