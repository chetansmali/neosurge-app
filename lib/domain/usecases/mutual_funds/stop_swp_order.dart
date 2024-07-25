import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/mutual_funds/stop_swp_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class StopSwpOrder extends UseCase<void, StopSwpParams> {
  final MutualFundRepository _mutualFundRepository;

  StopSwpOrder(this._mutualFundRepository);

  @override
  Future<Either<AppError, void>> call(StopSwpParams params) =>
      _mutualFundRepository.stopSwpOrder(params.toJson());
}
