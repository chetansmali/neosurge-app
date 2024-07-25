import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/mutual_funds/mutual_fund.dart';
import '../../entities/app_error.dart';
import '../../entities/params/mutual_funds/get_funds_by_investment_idea_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class GetFundsByInvestmentIdea
    extends UseCase<List<MutualFund>, GetFundsByInvestmentIdeaParams> {
  final MutualFundRepository _mutualFundRepository;

  GetFundsByInvestmentIdea(this._mutualFundRepository);

  @override
  Future<Either<AppError, List<MutualFund>>> call(
    GetFundsByInvestmentIdeaParams params,
  ) =>
      _mutualFundRepository.getFundsByInvestmentIdea(
        params.toJson(),
      );
}
