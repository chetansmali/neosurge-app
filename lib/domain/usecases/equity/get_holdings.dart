import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/equity/equity_portfolio/portfolio_holdings.dart';
import '../../entities/app_error.dart';
import '../../entities/params/equity/equity_orders/equity_holding_position_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/equity_respository.dart';

@injectable
class GetEquityholdings
    extends UseCase<PortfolioHoldingsModel, EquityHoldingPortfolioParams> {
  final EquityRespository equityRespository;
  GetEquityholdings(this.equityRespository);

  @override
  Future<Either<AppError, PortfolioHoldingsModel>> call(params) =>
      equityRespository.getPortfolioHoldings(params.toJson());
}
