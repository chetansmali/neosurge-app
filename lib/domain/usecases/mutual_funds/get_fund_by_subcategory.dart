import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/mutual_funds/mutual_fund.dart';
import '../../entities/app_error.dart';
import '../../entities/params/mutual_funds/get_funds_by_subcategory_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class GetFundsBySubCategory
    extends UseCase<List<MutualFund>, GetFundsBySubCategoryParams> {
  final MutualFundRepository _mutualFundRepository;

  GetFundsBySubCategory(this._mutualFundRepository);

  @override
  Future<Either<AppError, List<MutualFund>>> call(
    GetFundsBySubCategoryParams params,
  ) =>
      _mutualFundRepository.getFundsBySubcategory(params.toJson());
}
