import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/mutual_funds/fund_detail.dart';
import '../../entities/app_error.dart';
import '../../entities/params/mutual_funds/get_mutual_fund_details_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class GetMutualFundDetail
    extends UseCase<FundDetail, GetMutualFundDetailsParams> {
  final MutualFundRepository _mutualFundRepository;

  GetMutualFundDetail(this._mutualFundRepository);

  @override
  Future<Either<AppError, FundDetail>> call(
          GetMutualFundDetailsParams params) =>
      _mutualFundRepository.getMutualFundDetail(params.toJson());
}
