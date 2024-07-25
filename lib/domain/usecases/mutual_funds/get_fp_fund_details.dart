import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/mutual_funds/fp_fund_details.dart';
import '../../entities/app_error.dart';
import '../../entities/params/mutual_funds/get_mutual_fund_by_isin_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class GetFpFundDetails
    extends UseCase<FpFundDetails, GetMutualFundByIsinParams> {
  final MutualFundRepository _mutualFundRepository;

  GetFpFundDetails(this._mutualFundRepository);

  @override
  Future<Either<AppError, FpFundDetails>> call(
          GetMutualFundByIsinParams params) =>
      _mutualFundRepository.getFpFundDetails(params.toJson());
}
