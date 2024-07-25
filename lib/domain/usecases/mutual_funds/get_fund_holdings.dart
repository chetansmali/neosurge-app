import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/mutual_funds/fund_holding.dart';
import '../../entities/app_error.dart';
import '../../entities/params/mutual_funds/get_mutual_fund_holdings_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class GetFundHoldings
    extends UseCase<List<FundHolding>, GetMutualFundHoldingParams> {
  final MutualFundRepository _mutualFundRepository;

  GetFundHoldings(this._mutualFundRepository);

  @override
  Future<Either<AppError, List<FundHolding>>> call(
          GetMutualFundHoldingParams params) =>
      _mutualFundRepository.getFundHoldings(params.toJson());
}
