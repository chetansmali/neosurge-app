import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/user_id_param.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class GenerateHoldingsReport extends UseCase<String, UserIdParam> {
  final MutualFundRepository _mfRepository;

  GenerateHoldingsReport(this._mfRepository);

  @override
  Future<Either<AppError, String>> call(UserIdParam params) =>
      _mfRepository.generateHoldingsReport(params.toJson());
}
