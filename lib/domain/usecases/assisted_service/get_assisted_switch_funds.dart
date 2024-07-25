import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/mutual_funds/fund.dart';
import '../../entities/app_error.dart';
import '../../entities/params/mutual_funds/get_switch_funds_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/assisted_service_repository.dart';

@injectable
class GetAssistedSwitchFunds extends UseCase<List<Fund>, GetSwitchFundsParams> {
  final AssistedServiceRepository _repository;

  GetAssistedSwitchFunds(this._repository);

  @override
  Future<Either<AppError, List<Fund>>> call(GetSwitchFundsParams params) =>
      _repository.getSwitchFunds(params.toJson());
}
