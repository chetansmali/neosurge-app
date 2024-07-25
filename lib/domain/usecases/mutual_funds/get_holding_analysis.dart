import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/mutual_funds/holding_analysis.dart';
import '../../entities/app_error.dart';
import '../../entities/params/mutual_funds/get_mutual_fund_details_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class GetHoldingAnalysis
    extends UseCase<HoldingAnalysis, GetMutualFundDetailsParams> {
  final MutualFundRepository _mutualFundRepository;

  GetHoldingAnalysis(this._mutualFundRepository);

  @override
  Future<Either<AppError, HoldingAnalysis>> call(
          GetMutualFundDetailsParams params) =>
      _mutualFundRepository.getHoldingAnalysis(params.toJson());
}
