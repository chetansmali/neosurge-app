import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/equity/equity_portfolio/get_smallcase_fund.dart';
import '../../entities/app_error.dart';
import '../../entities/params/equity/equity_portfolio/get_holdings_token_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/equity_respository.dart';

@injectable
class GetEquityHoldingsToken
    extends UseCase<GetFundsModel, EquityHoldingsTokenParams> {
  final EquityRespository equityRespository;

  GetEquityHoldingsToken(this.equityRespository);

  @override
  Future<Either<AppError, GetFundsModel>> call(
          EquityHoldingsTokenParams params) =>
      equityRespository.getEquityHoldingsToken(params.toJson());
}
