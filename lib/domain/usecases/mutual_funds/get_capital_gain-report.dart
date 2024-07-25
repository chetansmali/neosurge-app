import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/mutual_funds/capital_gain_report_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/mutual_funds/capital_gain_report_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class GetCapitalGainReport
    extends UseCase<CapitalGainReportModel, CapitalGainReportParams> {
  final MutualFundRepository _mfRepository;

  GetCapitalGainReport(this._mfRepository);

  @override
  Future<Either<AppError, CapitalGainReportModel>> call(
          CapitalGainReportParams params) =>
      _mfRepository.getCapitalGainsReport(params.toJson());
}
