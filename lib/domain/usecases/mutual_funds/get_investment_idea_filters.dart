import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/mutual_funds/get_investment_idea_filters_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class GetInvestmentIdeaFilters
    extends UseCase<List<String>, GetInvestmentIdeaFiltersParams> {
  final MutualFundRepository _mutualFundRepository;

  GetInvestmentIdeaFilters(this._mutualFundRepository);

  @override
  Future<Either<AppError, List<String>>> call(
    GetInvestmentIdeaFiltersParams params,
  ) =>
      _mutualFundRepository.getInvestmentIdeaFilters(
        params.toJson(),
      );
}
