import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/mutual_funds/nav_history.dart';
import '../../entities/app_error.dart';
import '../../entities/params/mutual_funds/get_mf_nav_history_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class GetMFNavHistory extends UseCase<List<NavHistory>, GetMFNavHistoryParams> {
  final MutualFundRepository _mutualFundRepository;

  GetMFNavHistory(this._mutualFundRepository);

  @override
  Future<Either<AppError, List<NavHistory>>> call(
          GetMFNavHistoryParams params) =>
      _mutualFundRepository.getMutualFundNavHistory(params.toJson());
}
