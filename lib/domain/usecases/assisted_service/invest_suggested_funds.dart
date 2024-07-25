import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/assisted_service/invest_suggested_funds_response.dart';
import '../../entities/app_error.dart';
import '../../entities/params/assisted_service/invest_suggested_funds_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/assisted_service_repository.dart';

@injectable
class InvestSuggestedFunds
    extends UseCase<InvestSuggestedFundsResponse, InvestSuggestedFundsParams> {
  final AssistedServiceRepository _assistedServiceRepository;

  InvestSuggestedFunds(this._assistedServiceRepository);

  @override
  Future<Either<AppError, InvestSuggestedFundsResponse>> call(InvestSuggestedFundsParams params) =>
      _assistedServiceRepository.investSuggestedFunds(params.toJson());
}
