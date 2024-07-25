import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/mutual_funds/stop_stp_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class StopStpOrder extends UseCase<void, StopStpParams> {
  final MutualFundRepository _mutualFundRepository;

  StopStpOrder(this._mutualFundRepository);

  @override
  Future<Either<AppError, void>> call(StopStpParams params) =>
      _mutualFundRepository.stopStpOrder(params.toJson());
}
