import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/equity/equity_portfolio/portfolio_positions.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/equity/equity_orders/equity_holding_position_params.dart';
import '../../../../domain/usecases/equity/get_position.dart';

part 'portfolio_positions_state.dart';

@injectable
class PortfolioPositionsCubit extends Cubit<PortfolioPositionsState> {
  final GetPositions getPositions;
  PortfolioPositionsCubit(this.getPositions)
      : super(PortfolioPositionsInitial());

  Future fetchPositions() async {
    emit(PortfolioPositionsLoading());
    final response = await getPositions(
        EquityHoldingPortfolioParams(instrumentType: 'EQUITY'));
    response.fold(
        (l) => emit(PortfolioPositionsFailure(
            errorType: l.errorType, errorMessage: l.error)),
        (r) => emit(PortfolioPositionsLoaded(r)));
  }

  Future fetchETFPositions() async {
    emit(PortfolioPositionsLoading());
    final response =
        await getPositions(EquityHoldingPortfolioParams(instrumentType: 'ETF'));
    response.fold(
        (l) => emit(PortfolioPositionsFailure(
            errorType: l.errorType, errorMessage: l.error)),
        (r) => emit(PortfolioPositionsLoaded(r)));
  }
}
