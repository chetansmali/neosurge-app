import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/assisted_service/suggested_fund.dart';
import '../../entities/app_error.dart';
import '../../entities/params/assisted_service/get_suggested_funds_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/assisted_service_repository.dart';

@injectable
class GetSuggestedFunds
    extends UseCase<List<SuggestedFund>, GetSuggestedFundsParams> {
  final AssistedServiceRepository _assistedServiceRepository;

  GetSuggestedFunds(this._assistedServiceRepository);

  @override
  Future<Either<AppError, List<SuggestedFund>>> call(
          GetSuggestedFundsParams params) =>
      _assistedServiceRepository.getSuggestedFunds(params.toJson());
}
