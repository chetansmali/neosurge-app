import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/mutual_funds/generate_capital_gain_file.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class GenereteCapitalGainsFile
    extends UseCase<void, GenerateCapitalGainFileParams> {
  final MutualFundRepository _mfRepository;

  GenereteCapitalGainsFile(this._mfRepository);

  @override
  Future<Either<AppError, void>> call(GenerateCapitalGainFileParams params) =>
      _mfRepository.generateCapitalGainFile(params.toJson());
}
