import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/mutual_funds/user_mf_holding.dart';
import '../../entities/app_error.dart';
import '../../entities/params/user_id_param.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class GetUserMFHoldings extends UseCase<UserMfHoldings?, UserIdParam> {
  final MutualFundRepository _mutualFundRepository;

  GetUserMFHoldings(this._mutualFundRepository);

  @override
  Future<Either<AppError, UserMfHoldings?>> call(UserIdParam params) =>
      _mutualFundRepository.getUserMFHoldings(params.toJson());
}
