import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/equity/equity_portfolio/portfolio_positions.dart';
import '../../entities/app_error.dart';
import '../../entities/params/equity/equity_orders/equity_holding_position_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/equity_respository.dart';

@injectable
class GetPositions
    extends UseCase<PortfolioPositionModel, EquityHoldingPortfolioParams> {
  final EquityRespository equityRespository;
  GetPositions(this.equityRespository);

  @override
  Future<Either<AppError, PortfolioPositionModel>> call(params) =>
      equityRespository.getPortfolioPositions(params.toJson());
}
