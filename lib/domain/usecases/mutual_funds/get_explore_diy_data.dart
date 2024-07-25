import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/mutual_funds/explore_diy_response.dart';
import '../../entities/app_error.dart';
import '../../entities/params/mutual_funds/get_explore_diy_data_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class GetExploreDIYData
    extends UseCase<ExploreDIYDataResponse, GetExploreDIYDataParams> {
  final MutualFundRepository _mutualFundRepository;

  GetExploreDIYData(this._mutualFundRepository);

  @override
  Future<Either<AppError, ExploreDIYDataResponse>> call(
          GetExploreDIYDataParams params) =>
      _mutualFundRepository.getExploreDIYData(params.toJson());
}
