import 'package:injectable/injectable.dart';

import '../../../data/models/import_external_funds/portfolio_analysis_response.dart';
import '../../entities/app_error.dart';
import 'package:dartz/dartz.dart';

import '../../entities/usecase.dart';
import '../../repositories/external_fund_repository.dart';

@injectable
class GetPortfolioAnalysis extends UseCase<PortfolioAnalysisResponse, int> {
  final ExternalFundRepository _externalFundRepository;

  GetPortfolioAnalysis(this._externalFundRepository);

  @override
  Future<Either<AppError, PortfolioAnalysisResponse>> call(int params) async =>
      await _externalFundRepository.getPortfolioAnalysis(params);
}
