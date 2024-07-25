import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/mutual_funds/fund.dart';
import '../../entities/app_error.dart';
import '../../entities/params/mutual_funds/get_mutual_fund_by_isin_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class GetMutualFundByIsin extends UseCase<Fund, GetMutualFundByIsinParams> {
  final MutualFundRepository _mutualFundRepository;

  GetMutualFundByIsin(this._mutualFundRepository);

  @override
  Future<Either<AppError, Fund>> call(GetMutualFundByIsinParams params) =>
      _mutualFundRepository.getFundByIsin(params.toJson());
}
